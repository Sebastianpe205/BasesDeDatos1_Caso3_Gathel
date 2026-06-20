/* =========================================================
   ÍNDICES - PROPOSITIONS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_CreatedByPlayerId')
BEGIN
    CREATE INDEX IX_Propositions_CreatedByPlayerId
    ON Propositions (CreatedByPlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_TargetPlayerId')
BEGIN
    CREATE INDEX IX_Propositions_TargetPlayerId
    ON Propositions (TargetPlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_StatusId')
BEGIN
    CREATE INDEX IX_Propositions_StatusId
    ON Propositions (StatusId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_TypeId')
BEGIN
    CREATE INDEX IX_Propositions_TypeId
    ON Propositions (TypeId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_AIValidationStatusId')
BEGIN
    CREATE INDEX IX_Propositions_AIValidationStatusId
    ON Propositions (AIValidationStatusId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_EventGroupId')
BEGIN
    CREATE INDEX IX_Propositions_EventGroupId
    ON Propositions (EventGroupId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_Status_Target')
BEGIN
    CREATE INDEX IX_Propositions_Status_Target
    ON Propositions (StatusId, TargetPlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Propositions_Creator_Status')
BEGIN
    CREATE INDEX IX_Propositions_Creator_Status
    ON Propositions (CreatedByPlayerId, StatusId);
END
GO


/* =========================================================
   ÍNDICES - PREDICTIONS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Predictions_PlayerId')
BEGIN
    CREATE INDEX IX_Predictions_PlayerId
    ON Predictions (PlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Predictions_PropositionId')
BEGIN
    CREATE INDEX IX_Predictions_PropositionId
    ON Predictions (PropositionId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Predictions_PredictionStatusId')
BEGIN
    CREATE INDEX IX_Predictions_PredictionStatusId
    ON Predictions (PredictionStatusId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Predictions_PredictionOutcomeId')
BEGIN
    CREATE INDEX IX_Predictions_PredictionOutcomeId
    ON Predictions (PredictionOutcomeId);
END
GO


/* =========================================================
   ÍNDICES - GAME EVENTS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GameEvents_EventTypeId')
BEGIN
    CREATE INDEX IX_GameEvents_EventTypeId
    ON GameEvents (EventTypeId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GameEvents_EventSourceId')
BEGIN
    CREATE INDEX IX_GameEvents_EventSourceId
    ON GameEvents (EventSourceId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GameEvents_EntityTypeId')
BEGIN
    CREATE INDEX IX_GameEvents_EntityTypeId
    ON GameEvents (EntityTypeId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GameEvents_RelatedEntityId')
BEGIN
    CREATE INDEX IX_GameEvents_RelatedEntityId
    ON GameEvents (RelatedEntityId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GameEvents_CreatedByPlayerId')
BEGIN
    CREATE INDEX IX_GameEvents_CreatedByPlayerId
    ON GameEvents (CreatedByPlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GameEvents_CreatedAt')
BEGIN
    CREATE INDEX IX_GameEvents_CreatedAt
    ON GameEvents (CreatedAt);
END
GO


/* =========================================================
   ÍNDICES - WALLET TRANSACTIONS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_WalletTransactions_WalletId')
BEGIN
    CREATE INDEX IX_WalletTransactions_WalletId
    ON WalletTransactions (WalletId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_WalletTransactions_WalletTransactionTypeId')
BEGIN
    CREATE INDEX IX_WalletTransactions_WalletTransactionTypeId
    ON WalletTransactions (WalletTransactionTypeId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_WalletTransactions_WalletBalanceFormatId')
BEGIN
    CREATE INDEX IX_WalletTransactions_WalletBalanceFormatId
    ON WalletTransactions (WalletBalanceFormatId);
END
GO


/* =========================================================
   ÍNDICES - PLAYER SOCIAL ACCOUNTS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PlayerSocialAccounts_PlayerId')
BEGIN
    CREATE INDEX IX_PlayerSocialAccounts_PlayerId
    ON PlayerSocialAccounts (PlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PlayerSocialAccounts_PlatformId')
BEGIN
    CREATE INDEX IX_PlayerSocialAccounts_PlatformId
    ON PlayerSocialAccounts (PlatformId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_PlayerSocialAccounts_IsVerified')
BEGIN
    CREATE INDEX IX_PlayerSocialAccounts_IsVerified
    ON PlayerSocialAccounts (IsVerified);
END
GO


/* =========================================================
   ÍNDICES - EVIDENCE SUBMISSIONS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_EvidenceSubmissions_PropositionId')
BEGIN
    CREATE INDEX IX_EvidenceSubmissions_PropositionId
    ON EvidenceSubmissions (PropositionId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_EvidenceSubmissions_SubmittedByPlayerId')
BEGIN
    CREATE INDEX IX_EvidenceSubmissions_SubmittedByPlayerId
    ON EvidenceSubmissions (SubmittedByPlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_EvidenceSubmissions_EvidenceTypeId')
BEGIN
    CREATE INDEX IX_EvidenceSubmissions_EvidenceTypeId
    ON EvidenceSubmissions (EvidenceTypeId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_EvidenceSubmissions_StatusId')
BEGIN
    CREATE INDEX IX_EvidenceSubmissions_StatusId
    ON EvidenceSubmissions (EvidenceSubmissionStatusId);
END
GO


/* =========================================================
   ÍNDICES - NOTIFICATIONS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Notifications_PlayerId')
BEGIN
    CREATE INDEX IX_Notifications_PlayerId
    ON Notifications (PlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Notifications_NotificationTypeId')
BEGIN
    CREATE INDEX IX_Notifications_NotificationTypeId
    ON Notifications (NotificationTypeId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Notifications_IsRead')
BEGIN
    CREATE INDEX IX_Notifications_IsRead
    ON Notifications (IsRead);
END
GO


/* =========================================================
   ÍNDICES - AUDIT LOGS
========================================================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_AuditLogs_PlayerId')
BEGIN
    CREATE INDEX IX_AuditLogs_PlayerId
    ON AuditLogs (PlayerId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_AuditLogs_AuditActionId')
BEGIN
    CREATE INDEX IX_AuditLogs_AuditActionId
    ON AuditLogs (AuditActionId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_AuditLogs_AuditEntityId')
BEGIN
    CREATE INDEX IX_AuditLogs_AuditEntityId
    ON AuditLogs (AuditEntityId);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_AuditLogs_EventDate')
BEGIN
    CREATE INDEX IX_AuditLogs_EventDate
    ON AuditLogs (EventDate);
END
GO