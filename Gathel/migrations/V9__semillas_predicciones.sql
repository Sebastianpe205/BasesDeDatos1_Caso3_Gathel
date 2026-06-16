/* =========================================================
   GENERAR 50 000 PREDICCIONES
========================================================= */

DECLARE @i INT = 1;

WHILE @i <= 50000
BEGIN

    DECLARE @PredictionId BIGINT;
    DECLARE @PredictionType INT;

    DECLARE @PropositionId BIGINT =
        ((ABS(CHECKSUM(NEWID())) % 5000) + 1);

    DECLARE @PlayerId BIGINT =
        ((ABS(CHECKSUM(NEWID())) % 1000) + 1);

    SET @PredictionType =
        (ABS(CHECKSUM(NEWID())) % 100);

    INSERT INTO Predictions
    (
        PropositionId,
        PlayerId,
        PredictionStatusId,
        PredictionOutcomeId,
        PredictionValue,
        IsPointPrediction,
        IsMoneyPrediction,
        CreatedAt,
        UpdatedAt,
        ClosedAt
    )
    VALUES
    (
        @PropositionId,

        @PlayerId,

        1, -- Pendiente

        CASE
            WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0
            THEN 1
            ELSE 2
        END,

        CASE
            WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0
            THEN 1
            ELSE 0
        END,

        CASE
            WHEN @PredictionType < 70
            THEN 1
            ELSE 0
        END,

        CASE
            WHEN @PredictionType >= 70
            THEN 1
            ELSE 0
        END,

        SYSUTCDATETIME(),
        NULL,
        NULL
    );

    SET @PredictionId = SCOPE_IDENTITY();

    /* ==========================================
       APUESTA POR PUNTOS
    ========================================== */

    IF @PredictionType < 70
    BEGIN

        INSERT INTO PredictionPointBets
        (
            PredictionId,
            PointsAmount,
            PointsWon,
            PlatformCommissionPoints,
            CreatorCommissionPoints,
            CreatedAt
        )
        VALUES
        (
            @PredictionId,

            1,

            NULL,

            NULL,

            NULL,

            SYSUTCDATETIME()
        );

    END

    /* ==========================================
       APUESTA POR DINERO
    ========================================== */

    ELSE
    BEGIN

        INSERT INTO PredictionMoneyBets
        (
            PredictionId,
            CurrencyId,
            MoneyAmount,
            MoneyWon,
            PlatformCommissionMoney,
            CreatorCommissionMoney,
            CreatedAt,
            UpdatedAt
        )
        VALUES
        (
            @PredictionId,

            3, -- USD

            CAST(
                ((ABS(CHECKSUM(NEWID())) % 10000) + 100)
                AS DECIMAL(19,4)
            ),

            NULL,

            NULL,

            NULL,

            SYSUTCDATETIME(),

            NULL
        );

    END

    SET @i += 1;

END;