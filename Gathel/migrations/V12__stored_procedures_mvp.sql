-- ============================================================
-- V12__stored_procedures_mvp.sql
-- Stored Procedures transaccionales del MVP de Gathel.
-- ============================================================
-- IDs de catalogo asumidos por estos SPs (verificar contra las
-- semillas reales en V2, V5, V7, etc. y ajustar si no coinciden):
--
--   PropositionStatuses.StatusId        1 = Pendiente / Activa
--   AIValidationStatuses.AIValidationStatusId  1 = Pendiente
--   PropositionTypes.TypeId             1 = Autopropuesta (Creador = Objetivo)
--                                        2 = Sobre otro jugador
--   PredictionStatuses.PredictionStatusId      1 = Activa
--   PredictionOutcomes.PredictionOutcomeId     3 = Pendiente (sin resolver)
--   WalletTypes.WalletTypeId            1 = Puntos, 2 = Dinero
--   WalletTransactionTypes.WalletTransactionTypeId  2 = Debito
--   WalletBalanceFormats.WalletBalanceFormatId      1 = Puntos, 2 = Dinero
-- ============================================================

--SP 1 - Obtener Balance (sin cambios)
CREATE OR ALTER PROCEDURE sp_ObtenerBalanceJugador
(
    @PlayerId BIGINT
)
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        p.PlayerId,
        p.Username,
        wt.WalletTypeName,
        w.CurrentBalance
    FROM Wallets w
        INNER JOIN WalletTypes wt
            ON wt.WalletTypeId = w.WalletTypeId
        INNER JOIN Players p
            ON p.PlayerId = w.PlayerId
    WHERE p.PlayerId = @PlayerId;

END;
GO

--SP 2 - Login (ajuste menor: @Email ahora coincide con el tamano de la columna)
CREATE OR ALTER PROCEDURE sp_Login
(
    @Email NVARCHAR(255)
)
AS
BEGIN

    SET NOCOUNT ON;

    SELECT
        p.PlayerId,
        p.Username,
        p.Email,
        ac.PasswordHash,
        ac.PasswordSalt,
        ac.IsBlocked,
        ac.IsActive
    FROM Players p
        INNER JOIN AuthenticationCredentials ac
            ON ac.PlayerId = p.PlayerId
    WHERE p.Email = @Email;

END;
GO

--SP 3 - Crear Proposicion
-- CAMBIOS:
--   1. Nuevo parametro opcional @EventGroupId: si se manda, la proposicion
--      se une a un grupo de evento EXISTENTE (en vez de crear uno nuevo
--      cada vez, que es lo que rompia la logica de votacion de 24h).
--   2. Se valida que el grupo exista, no este cerrado, y no haya pasado
--      su VotingDeadline antes de unir la proposicion a el.
--   3. Se agrega un SELECT final devolviendo el PropositionId y el
--      EventGroupId resultantes, para que el backend sepa que se creo.
CREATE OR ALTER PROCEDURE sp_CrearProposicion
(
    @CreatedByPlayerId BIGINT,
    @TargetPlayerId BIGINT,
    @Title NVARCHAR(400),
    @Description NVARCHAR(MAX),
    @EventDate DATETIME2,
    @EventGroupId BIGINT = NULL
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        DECLARE @TypeId BIGINT;
        DECLARE @PropositionId BIGINT;

        IF @EventGroupId IS NOT NULL
        BEGIN
            -- El frontend indica que esta proposicion es sobre un evento
            -- que ya existe (alguien mas ya propuso sobre el). Se valida
            -- que el grupo siga abierto antes de unirse a el.
            IF NOT EXISTS (
                SELECT 1
                FROM PropositionGroups
                WHERE EventGroupId = @EventGroupId
                  AND TargetPlayerId = @TargetPlayerId
                  AND IsVotingClosed = 0
                  AND VotingDeadline > SYSUTCDATETIME()
            )
            BEGIN
                THROW 50001, 'El grupo de evento indicado no existe, ya cerro su votacion, o no corresponde a ese jugador objetivo.', 1;
            END
        END
        ELSE
        BEGIN
            -- Evento nuevo: se crea un grupo con ventana de 24 horas
            -- a partir de esta primera proposicion.
            INSERT INTO PropositionGroups
            (
                TargetPlayerId,
                FirstPropositionCreatedAt,
                VotingDeadline,
                WinningPropositionId,
                IsVotingClosed,
                CreatedAt
            )
            VALUES
            (
                @TargetPlayerId,
                SYSUTCDATETIME(),
                DATEADD(HOUR, 24, SYSUTCDATETIME()),
                NULL,
                0,
                SYSUTCDATETIME()
            );

            SET @EventGroupId = SCOPE_IDENTITY();
        END

        IF @CreatedByPlayerId = @TargetPlayerId
            SET @TypeId = 1;
        ELSE
            SET @TypeId = 2;

        INSERT INTO Propositions
        (
            CreatedByPlayerId,
            TargetPlayerId,
            StatusId,
            TypeId,
            AIValidationStatusId,
            EventGroupId,
            Title,
            Description,
            EventDate,
            PredictionCloseDate,
            IsPublic,
            RequiresMoneyPrediction,
            RequiresPointPrediction
        )
        VALUES
        (
            @CreatedByPlayerId,
            @TargetPlayerId,
            1,
            @TypeId,
            1,
            @EventGroupId,
            @Title,
            @Description,
            @EventDate,
            DATEADD(DAY, -1, @EventDate),
            1,
            1,
            1
        );

        SET @PropositionId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT
            @PropositionId AS PropositionId,
            @EventGroupId  AS EventGroupId;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO

--SP 4 - Crear Prediccion
-- CAMBIOS:
--   1. PredictionOutcomeId ya NO se deriva de @PredictionValue (eso
--      confundia "que predijo" con "si acerto", y el resultado no se
--      puede saber hasta que la proposicion se resuelva). Ahora se fija
--      en el ID de "Pendiente" del catalogo PredictionOutcomes.
--   2. Se agrega validacion de saldo suficiente (THROW si no alcanza).
--   3. Se agrega el debito real de la wallet correspondiente y su
--      WalletTransaction, tanto para puntos como para dinero.
--   4. Se agrega un SELECT final devolviendo el PredictionId creado.
CREATE OR ALTER PROCEDURE sp_CrearPrediccion
(
    @PropositionId BIGINT,
    @PlayerId BIGINT,
    @PredictionValue BIT,

    @EsPuntos BIT,
    @EsDinero BIT,

    @MontoPuntos INT = NULL,

    @CurrencyId BIGINT = NULL,
    @MontoDinero DECIMAL(19,4) = NULL
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        DECLARE @PredictionId BIGINT;
        DECLARE @PendingOutcomeId BIGINT = 3; -- "Pendiente" en PredictionOutcomes

        INSERT INTO Predictions
        (
            PropositionId,
            PlayerId,
            PredictionStatusId,
            PredictionOutcomeId,
            PredictionValue,
            IsPointPrediction,
            IsMoneyPrediction
        )
        VALUES
        (
            @PropositionId,
            @PlayerId,
            1,
            @PendingOutcomeId,
            @PredictionValue,
            @EsPuntos,
            @EsDinero
        );

        SET @PredictionId = SCOPE_IDENTITY();

        ------------------------------------------------------------
        -- Apuesta en PUNTOS: validar saldo, descontar, registrar
        ------------------------------------------------------------
        IF @EsPuntos = 1
        BEGIN

            DECLARE @PointsWalletId BIGINT;
            DECLARE @PointsBalance DECIMAL(19,4);

            SELECT
                @PointsWalletId = WalletId,
                @PointsBalance = CurrentBalance
            FROM Wallets
            WHERE PlayerId = @PlayerId
              AND WalletTypeId = 1; -- 1 = Puntos

            IF @PointsWalletId IS NULL
                THROW 50002, 'El jugador no tiene una wallet de puntos.', 1;

            IF @PointsBalance < @MontoPuntos
                THROW 50003, 'Saldo de puntos insuficiente para esta prediccion.', 1;

            UPDATE Wallets
            SET CurrentBalance = CurrentBalance - @MontoPuntos,
                UpdatedAt = SYSUTCDATETIME()
            WHERE WalletId = @PointsWalletId;

            INSERT INTO WalletTransactions
            (
                WalletId,
                WalletTransactionTypeId,
                WalletBalanceFormatId,
                Amount,
                PreviousBalance,
                NewBalance,
                ObjectSource,
                ReferenceId,
                Description,
                TransactionDate,
                CreatedByPlayerId
            )
            VALUES
            (
                @PointsWalletId,
                2, -- Debito
                1, -- Puntos
                @MontoPuntos,
                @PointsBalance,
                @PointsBalance - @MontoPuntos,
                'Predictions',
                @PredictionId,
                'Debito por prediccion en puntos',
                SYSUTCDATETIME(),
                @PlayerId
            );

            INSERT INTO PredictionPointBets
            (
                PredictionId,
                PointsAmount
            )
            VALUES
            (
                @PredictionId,
                @MontoPuntos
            );

        END

        ------------------------------------------------------------
        -- Apuesta en DINERO: validar saldo, descontar, registrar
        ------------------------------------------------------------
        IF @EsDinero = 1
        BEGIN

            DECLARE @MoneyWalletId BIGINT;
            DECLARE @MoneyBalance DECIMAL(19,4);

            SELECT
                @MoneyWalletId = WalletId,
                @MoneyBalance = CurrentBalance
            FROM Wallets
            WHERE PlayerId = @PlayerId
              AND WalletTypeId = 2 -- Dinero
              AND CurrencyId = @CurrencyId;

            IF @MoneyWalletId IS NULL
                THROW 50004, 'El jugador no tiene una wallet de dinero en esa moneda.', 1;

            IF @MoneyBalance < @MontoDinero
                THROW 50005, 'Saldo de dinero insuficiente para esta prediccion.', 1;

            UPDATE Wallets
            SET CurrentBalance = CurrentBalance - @MontoDinero,
                UpdatedAt = SYSUTCDATETIME()
            WHERE WalletId = @MoneyWalletId;

            INSERT INTO WalletTransactions
            (
                WalletId,
                WalletTransactionTypeId,
                WalletBalanceFormatId,
                Amount,
                PreviousBalance,
                NewBalance,
                ObjectSource,
                ReferenceId,
                Description,
                TransactionDate,
                CreatedByPlayerId
            )
            VALUES
            (
                @MoneyWalletId,
                2, -- Debito
                2, -- Dinero
                @MontoDinero,
                @MoneyBalance,
                @MoneyBalance - @MontoDinero,
                'Predictions',
                @PredictionId,
                'Debito por prediccion en dinero',
                SYSUTCDATETIME(),
                @PlayerId
            );

            INSERT INTO PredictionMoneyBets
            (
                PredictionId,
                CurrencyId,
                MoneyAmount
            )
            VALUES
            (
                @PredictionId,
                @CurrencyId,
                @MontoDinero
            );

        END

        COMMIT TRANSACTION;

        SELECT @PredictionId AS PredictionId;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO
