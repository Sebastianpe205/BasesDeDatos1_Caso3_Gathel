--SP 1 - Obtener Balance
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
--SP 2 - Login
CREATE OR ALTER PROCEDURE sp_Login
(
    @Email NVARCHAR(510)
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
--SP 3 - Crear Proposición
CREATE OR ALTER PROCEDURE sp_CrearProposicion
(
    @CreatedByPlayerId BIGINT,
    @TargetPlayerId BIGINT,
    @Title NVARCHAR(400),
    @Description NVARCHAR(MAX),
    @EventDate DATETIME2
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;

        DECLARE @EventGroupId BIGINT;
        DECLARE @TypeId BIGINT;

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
            DATEADD(HOUR,24,SYSUTCDATETIME()),
            NULL,
            0,
            SYSUTCDATETIME()
        );

        SET @EventGroupId = SCOPE_IDENTITY();

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
            DATEADD(DAY,-1,@EventDate),
            1,
            1,
            1
        );

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO
--SP 4 - Crear Predicción
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
            CASE
                WHEN @PredictionValue = 1 THEN 1
                ELSE 2
            END,
            @PredictionValue,
            @EsPuntos,
            @EsDinero
        );

        SET @PredictionId = SCOPE_IDENTITY();

        IF @EsPuntos = 1
        BEGIN

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

        IF @EsDinero = 1
        BEGIN

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

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH

END;
GO