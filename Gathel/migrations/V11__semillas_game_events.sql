/* =========================================================
   GENERAR 250000 GAME EVENTS
========================================================= */

DECLARE @i INT = 1;

WHILE @i <= 250000
BEGIN

    INSERT INTO GameEvents
    (
        EventTypeId,
        EventSourceId,
        EntityTypeId,
        RelatedEntityId,
        EventData,
        CreatedByPlayerId,
        CreatedAt
    )
    VALUES
    (
        (ABS(CHECKSUM(NEWID())) % 10) + 1,

        (ABS(CHECKSUM(NEWID())) % 5) + 1,

        (ABS(CHECKSUM(NEWID())) % 7) + 1,

        CASE
            WHEN (ABS(CHECKSUM(NEWID())) % 3) = 0
                THEN (ABS(CHECKSUM(NEWID())) % 1000) + 1
            WHEN (ABS(CHECKSUM(NEWID())) % 3) = 1
                THEN (ABS(CHECKSUM(NEWID())) % 5000) + 1
            ELSE
                (ABS(CHECKSUM(NEWID())) % 50000) + 1
        END,

        CONCAT(
            N'{"evento":"',
            (ABS(CHECKSUM(NEWID())) % 10) + 1,
            N'","origen":"simulado"}'
        ),

        (ABS(CHECKSUM(NEWID())) % 1000) + 1,

        DATEADD(
            DAY,
            -(ABS(CHECKSUM(NEWID())) % 365),
            SYSUTCDATETIME()
        )
    );

    SET @i += 1;

END;