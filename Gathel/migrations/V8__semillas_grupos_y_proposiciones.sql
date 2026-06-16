/* =========================================================
   GENERAR 5000 GRUPOS DE PROPOSICIONES
========================================================= */

DECLARE @i INT = 1;

WHILE @i <= 5000
BEGIN

    DECLARE @TargetPlayerId BIGINT =
        ((ABS(CHECKSUM(NEWID())) % 1000) + 1);

    INSERT INTO PropositionGroups
    (
        TargetPlayerId,
        FirstPropositionCreatedAt,
        VotingDeadline,
        WinningPropositionId,
        IsVotingClosed,
        CreatedAt,
        UpdatedAt
    )
    VALUES
    (
        @TargetPlayerId,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, SYSUTCDATETIME()),
        DATEADD(HOUR, 24, SYSUTCDATETIME()),
        NULL,
        0,
        SYSUTCDATETIME(),
        NULL
    );

    DECLARE @EventGroupId BIGINT = SCOPE_IDENTITY();

    DECLARE @CreatorPlayerId BIGINT =
        ((ABS(CHECKSUM(NEWID())) % 1000) + 1);

    DECLARE @TypeId BIGINT;

    IF @CreatorPlayerId = @TargetPlayerId
        SET @TypeId = 1; -- Propia
    ELSE
        SET @TypeId = 2; -- Tercero

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
        ResolutionDate,
        IsPublic,
        RequiresMoneyPrediction,
        RequiresPointPrediction,
        CreatedAt,
        UpdatedAt,
        DeletedAt
    )
    VALUES
    (
        @CreatorPlayerId,
        @TargetPlayerId,

        /* Estado */
        ((ABS(CHECKSUM(NEWID())) % 4) + 3),

        @TypeId,

        /* IA */
        CASE
            WHEN (ABS(CHECKSUM(NEWID())) % 100) < 85 THEN 2
            ELSE 4
        END,

        @EventGroupId,

        CONCAT(
            N'Jugador ',
            @TargetPlayerId,
            N' alcanzará una meta importante'
        ),

        CONCAT(
            N'Proposición generada automáticamente para pruebas del sistema. Jugador objetivo ',
            @TargetPlayerId
        ),

        DATEADD(
            DAY,
            (ABS(CHECKSUM(NEWID())) % 90),
            SYSUTCDATETIME()
        ),

        DATEADD(
            DAY,
            (ABS(CHECKSUM(NEWID())) % 30),
            SYSUTCDATETIME()
        ),

        NULL,

        1,

        CASE
            WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0
            THEN 1
            ELSE 0
        END,

        CASE
            WHEN (ABS(CHECKSUM(NEWID())) % 2) = 0
            THEN 1
            ELSE 0
        END,

        SYSUTCDATETIME(),

        NULL,

        NULL
    );

    SET @i += 1;

END;