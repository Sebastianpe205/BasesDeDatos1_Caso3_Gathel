CREATE OR ALTER TRIGGER TR_Propositions_Insert
ON Propositions
AFTER INSERT
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO AuditLogs
    (
        PlayerId,
        AuditActionId,
        AuditEntityId,
        ReferenceId,
        Observations,
        EventDate
    )
    SELECT
        CreatedByPlayerId,
        1,
        1,
        PropositionId,
        CONCAT('Proposición creada: ', Title),
        SYSUTCDATETIME()
    FROM inserted;

END;
GO
CREATE OR ALTER TRIGGER TR_Predictions_Insert
ON Predictions
AFTER INSERT
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO AuditLogs
    (
        PlayerId,
        AuditActionId,
        AuditEntityId,
        ReferenceId,
        Observations,
        EventDate
    )
    SELECT
        PlayerId,
        1,
        2,
        PredictionId,
        CONCAT('Predicción creada para proposición ', PropositionId),
        SYSUTCDATETIME()
    FROM inserted;

END;
GO
CREATE OR ALTER TRIGGER TR_Wallets_Update
ON Wallets
AFTER UPDATE
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO AuditLogs
    (
        PlayerId,
        AuditActionId,
        AuditEntityId,
        ReferenceId,
        PreviousValue,
        NewValue,
        Observations,
        EventDate
    )
    SELECT
        i.PlayerId,
        2,
        3,
        i.WalletId,
        CAST(d.CurrentBalance AS NVARCHAR(100)),
        CAST(i.CurrentBalance AS NVARCHAR(100)),
        'Cambio de balance',
        SYSUTCDATETIME()
    FROM inserted i
    INNER JOIN deleted d
        ON i.WalletId = d.WalletId;

END;
GO
CREATE OR ALTER TRIGGER TR_Propositions_Delete
ON Propositions
AFTER DELETE
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO AuditLogs
    (
        PlayerId,
        AuditActionId,
        AuditEntityId,
        ReferenceId,
        Observations,
        EventDate
    )
    SELECT
        CreatedByPlayerId,
        3,
        1,
        PropositionId,
        'Proposición eliminada',
        SYSUTCDATETIME()
    FROM deleted;

END;
GO