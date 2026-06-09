-- ============================================================
-- Gathel: Gaming the Life
-- Script de creacion de tablas — SQL Server
-- ============================================================
-- Instrucciones:
--   1. Ejecutar contra una base de datos Gathel vacia.
--   2. El script maneja la dependencia circular entre
--      PropositionGroups <-> Propositions mediante ALTER TABLE.
--   3. El orden de creacion respeta todas las dependencias FK.
--   4. Total de tablas: 92
-- ============================================================
/*
USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Gathel')
    CREATE DATABASE Gathel
        COLLATE Latin1_General_CI_AS;
GO

USE Gathel;
GO
*/
-- ============================================================
-- SECCION 1 — TABLAS DE CATALOGO (sin dependencias FK)
-- ============================================================

CREATE TABLE Genders (
    GenderId   BIGINT        IDENTITY(1,1) NOT NULL,
    GenderName NVARCHAR(30)               NOT NULL,
    CreatedAt  DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Genders          PRIMARY KEY (GenderId),
    CONSTRAINT UQ_Genders_GenderName UNIQUE  (GenderName)
);
GO

CREATE TABLE Languages (
    LanguageId   BIGINT        IDENTITY(1,1) NOT NULL,
    LanguageCode NVARCHAR(10)               NOT NULL,
    LanguageName NVARCHAR(50)               NOT NULL,
    CreatedAt    DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Languages            PRIMARY KEY (LanguageId),
    CONSTRAINT UQ_Languages_LanguageCode UNIQUE  (LanguageCode)
);
GO

CREATE TABLE Countries (
    CountryId   BIGINT         IDENTITY(1,1) NOT NULL,
    CountryName NVARCHAR(100)               NOT NULL,
    Iso2Code    CHAR(2)                     NOT NULL,
    Iso3Code    CHAR(3)                     NOT NULL,
    PhoneCode   NVARCHAR(10)                    NULL,
    TimeZone    NVARCHAR(100)                   NULL,
    IsActive    BIT                         NOT NULL DEFAULT 1,
    CreatedAt   DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt   DATETIME2                       NULL,
    RowVersion  ROWVERSION                  NOT NULL,
    CONSTRAINT PK_Countries          PRIMARY KEY (CountryId),
    CONSTRAINT UQ_Countries_Iso2Code UNIQUE  (Iso2Code),
    CONSTRAINT UQ_Countries_Iso3Code UNIQUE  (Iso3Code)
);
GO

CREATE TABLE SocialPlatforms (
    PlatformId   BIGINT        IDENTITY(1,1) NOT NULL,
    PlatformName NVARCHAR(50)               NOT NULL,
    PlatformUrl  NVARCHAR(255)                  NULL,
    IsActive     BIT                        NOT NULL DEFAULT 1,
    CreatedAt    DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SocialPlatforms            PRIMARY KEY (PlatformId),
    CONSTRAINT UQ_SocialPlatforms_PlatformName UNIQUE  (PlatformName)
);
GO

CREATE TABLE PropositionStatuses (
    StatusId    BIGINT        IDENTITY(1,1) NOT NULL,
    StatusName  NVARCHAR(50)               NOT NULL,
    Description NVARCHAR(255)                  NULL,
    CreatedAt   DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionStatuses PRIMARY KEY (StatusId)
);
GO

CREATE TABLE PropositionTypes (
    TypeId      BIGINT        IDENTITY(1,1) NOT NULL,
    TypeName    NVARCHAR(50)               NOT NULL,
    Description NVARCHAR(255)                  NULL,
    CreatedAt   DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionTypes PRIMARY KEY (TypeId)
);
GO

CREATE TABLE AIValidationStatuses (
    AIValidationStatusId   BIGINT       IDENTITY(1,1) NOT NULL,
    AIValidationStatusName NVARCHAR(50)              NOT NULL,
    CreatedAt              DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_AIValidationStatuses PRIMARY KEY (AIValidationStatusId)
);
GO

CREATE TABLE WinningPredictionOptions (
    WinningPredictionOptionId   BIGINT       IDENTITY(1,1) NOT NULL,
    WinningPredictionOptionName NVARCHAR(50)              NOT NULL,
    CreatedAt                   DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_WinningPredictionOptions PRIMARY KEY (WinningPredictionOptionId)
);
GO

CREATE TABLE PredictionStatuses (
    PredictionStatusId   BIGINT        IDENTITY(1,1) NOT NULL,
    PredictionStatusName NVARCHAR(50)               NOT NULL,
    Description          NVARCHAR(255)                  NULL,
    CreatedAt            DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PredictionStatuses PRIMARY KEY (PredictionStatusId)
);
GO

CREATE TABLE PredictionOutcomes (
    PredictionOutcomeId   BIGINT        IDENTITY(1,1) NOT NULL,
    PredictionOutcomeName NVARCHAR(50)               NOT NULL,
    Description           NVARCHAR(255)                  NULL,
    CreatedAt             DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PredictionOutcomes PRIMARY KEY (PredictionOutcomeId)
);
GO

CREATE TABLE PredictionAdjustmentReasons (
    PredictionAdjustmentReasonId BIGINT        IDENTITY(1,1) NOT NULL,
    AdjustmentReasonName         NVARCHAR(100)              NOT NULL,
    CreatedAt                    DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PredictionAdjustmentReasons PRIMARY KEY (PredictionAdjustmentReasonId)
);
GO

CREATE TABLE EvidenceTypes (
    EvidenceTypeId BIGINT        IDENTITY(1,1) NOT NULL,
    TypeName       NVARCHAR(50)               NOT NULL,
    Description    NVARCHAR(255)                  NULL,
    CreatedAt      DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EvidenceTypes PRIMARY KEY (EvidenceTypeId)
);
GO

CREATE TABLE EvidenceSubmissionStatuses (
    EvidenceSubmissionStatusId   BIGINT       IDENTITY(1,1) NOT NULL,
    EvidenceSubmissionStatusName NVARCHAR(50)              NOT NULL,
    CreatedAt                    DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EvidenceSubmissionStatuses PRIMARY KEY (EvidenceSubmissionStatusId)
);
GO

CREATE TABLE FileTypes (
    FileTypeId   BIGINT       IDENTITY(1,1) NOT NULL,
    FileTypeName NVARCHAR(50)              NOT NULL,
    CreatedAt    DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_FileTypes PRIMARY KEY (FileTypeId)
);
GO

CREATE TABLE MediaTypes (
    MediaTypeId   BIGINT       IDENTITY(1,1) NOT NULL,
    MediaTypeName NVARCHAR(50)              NOT NULL,
    CreatedAt     DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_MediaTypes PRIMARY KEY (MediaTypeId)
);
GO

CREATE TABLE EvidenceValidationStatuses (
    EvidenceValidationStatusId   BIGINT       IDENTITY(1,1) NOT NULL,
    EvidenceValidationStatusName NVARCHAR(50)              NOT NULL,
    CreatedAt                    DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EvidenceValidationStatuses PRIMARY KEY (EvidenceValidationStatusId)
);
GO

CREATE TABLE EventTypes (
    EventTypeId   BIGINT        IDENTITY(1,1) NOT NULL,
    EventTypeName NVARCHAR(100)               NOT NULL,
    CreatedAt     DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EventTypes PRIMARY KEY (EventTypeId)
);
GO

CREATE TABLE EntityTypes (
    EntityTypeId   BIGINT       IDENTITY(1,1) NOT NULL,
    EntityTypeName NVARCHAR(50)              NOT NULL,
    CreatedAt      DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EntityTypes PRIMARY KEY (EntityTypeId)
);
GO

CREATE TABLE EventSources (
    EventSourceId   BIGINT        IDENTITY(1,1) NOT NULL,
    EventSourceName NVARCHAR(100)               NOT NULL,
    CreatedAt       DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EventSources PRIMARY KEY (EventSourceId)
);
GO

CREATE TABLE PropositionClosureReasons (
    PropositionClosureReasonId BIGINT        IDENTITY(1,1) NOT NULL,
    ClosureReasonName          NVARCHAR(100)              NOT NULL,
    CreatedAt                  DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionClosureReasons PRIMARY KEY (PropositionClosureReasonId)
);
GO

CREATE TABLE PropositionDisputeStatuses (
    PropositionDisputeStatusId BIGINT       IDENTITY(1,1) NOT NULL,
    DisputeStatusName          NVARCHAR(50)              NOT NULL,
    CreatedAt                  DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionDisputeStatuses PRIMARY KEY (PropositionDisputeStatusId)
);
GO

CREATE TABLE Tags (
    TagId       BIGINT        IDENTITY(1,1) NOT NULL,
    TagName     NVARCHAR(50)               NOT NULL,
    Description NVARCHAR(255)                  NULL,
    CreatedAt   DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Tags          PRIMARY KEY (TagId),
    CONSTRAINT UQ_Tags_TagName  UNIQUE      (TagName)
);
GO

CREATE TABLE Currencies (
    CurrencyId   BIGINT        IDENTITY(1,1) NOT NULL,
    CurrencyCode NVARCHAR(10)               NOT NULL,
    CurrencyName NVARCHAR(50)               NOT NULL,
    CreatedAt    DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_Currencies              PRIMARY KEY (CurrencyId),
    CONSTRAINT UQ_Currencies_CurrencyCode UNIQUE      (CurrencyCode)
);
GO

CREATE TABLE WalletTypes (
    WalletTypeId   BIGINT        IDENTITY(1,1) NOT NULL,
    WalletTypeName NVARCHAR(30)               NOT NULL,
    Description    NVARCHAR(255)                  NULL,
    CreatedAt      DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_WalletTypes              PRIMARY KEY (WalletTypeId),
    CONSTRAINT UQ_WalletTypes_WalletTypeName UNIQUE   (WalletTypeName)
);
GO

CREATE TABLE WalletTransactionTypes (
    WalletTransactionTypeId BIGINT       IDENTITY(1,1) NOT NULL,
    TransactionTypeName     NVARCHAR(50)              NOT NULL,
    CreatedAt               DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_WalletTransactionTypes PRIMARY KEY (WalletTransactionTypeId)
);
GO

CREATE TABLE WalletBalanceFormats (
    WalletBalanceFormatId BIGINT       IDENTITY(1,1) NOT NULL,
    BalanceFormatName     NVARCHAR(20)              NOT NULL,
    CreatedAt             DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_WalletBalanceFormats PRIMARY KEY (WalletBalanceFormatId)
);
GO

CREATE TABLE PaymentMethods (
    PaymentMethodId   BIGINT         IDENTITY(1,1) NOT NULL,
    PaymentMethodName NVARCHAR(50)                NOT NULL,
    Description       NVARCHAR(300)                   NULL,
    Configuration     NVARCHAR(MAX)                   NULL,
    IsActive          BIT                         NOT NULL DEFAULT 1,
    CreatedAt         DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt         DATETIME2                       NULL,
    RowVersion        ROWVERSION                  NOT NULL,
    CONSTRAINT PK_PaymentMethods PRIMARY KEY (PaymentMethodId)
);
GO

CREATE TABLE PaymentStatuses (
    PaymentStatusId   BIGINT        IDENTITY(1,1) NOT NULL,
    PaymentStatusName NVARCHAR(50)               NOT NULL,
    Description       NVARCHAR(300)                  NULL,
    IsActive          BIT                        NOT NULL DEFAULT 1,
    CreatedAt         DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PaymentStatuses PRIMARY KEY (PaymentStatusId)
);
GO

CREATE TABLE FinancialMovementTypes (
    FinancialMovementTypeId BIGINT       IDENTITY(1,1) NOT NULL,
    MovementTypeName        NVARCHAR(30)              NOT NULL,
    CreatedAt               DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_FinancialMovementTypes PRIMARY KEY (FinancialMovementTypeId)
);
GO

CREATE TABLE SocialVerificationMethods (
    SocialVerificationMethodId   BIGINT       IDENTITY(1,1) NOT NULL,
    SocialVerificationMethodName NVARCHAR(50)              NOT NULL,
    CreatedAt                    DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SocialVerificationMethods PRIMARY KEY (SocialVerificationMethodId)
);
GO

CREATE TABLE SocialVerificationStatuses (
    SocialVerificationStatusId   BIGINT       IDENTITY(1,1) NOT NULL,
    SocialVerificationStatusName NVARCHAR(50)              NOT NULL,
    CreatedAt                    DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SocialVerificationStatuses PRIMARY KEY (SocialVerificationStatusId)
);
GO

CREATE TABLE NotificationTypes (
    NotificationTypeId   BIGINT        IDENTITY(1,1) NOT NULL,
    NotificationTypeName NVARCHAR(100)               NOT NULL,
    Description          NVARCHAR(500)                   NULL,
    AllowsEmail          BIT                         NOT NULL DEFAULT 0,
    AllowsPush           BIT                         NOT NULL DEFAULT 0,
    AllowsSMS            BIT                         NOT NULL DEFAULT 0,
    IsActive             BIT                         NOT NULL DEFAULT 1,
    CreatedAt            DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    RowVersion           ROWVERSION                  NOT NULL,
    CONSTRAINT PK_NotificationTypes PRIMARY KEY (NotificationTypeId)
);
GO

CREATE TABLE SystemConfigurations (
    SystemConfigurationId BIGINT         IDENTITY(1,1) NOT NULL,
    ConfigurationKey      NVARCHAR(150)               NOT NULL,
    ConfigurationValue    NVARCHAR(500)                   NULL,
    DataType              NVARCHAR(50)                    NULL,
    Description           NVARCHAR(500)                   NULL,
    IsEditable            BIT                         NOT NULL DEFAULT 1,
    IsActive              BIT                         NOT NULL DEFAULT 1,
    CreatedAt             DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt             DATETIME2                       NULL,
    RowVersion            ROWVERSION                  NOT NULL,
    CONSTRAINT PK_SystemConfigurations                PRIMARY KEY (SystemConfigurationId),
    CONSTRAINT UQ_SystemConfigurations_ConfigurationKey UNIQUE   (ConfigurationKey)
);
GO

CREATE TABLE FeatureFlags (
    FeatureFlagId   BIGINT         IDENTITY(1,1) NOT NULL,
    FeatureFlagName NVARCHAR(150)               NOT NULL,
    Description     NVARCHAR(500)                   NULL,
    IsEnabled       BIT                         NOT NULL DEFAULT 0,
    StartDate       DATETIME2                       NULL,
    EndDate         DATETIME2                       NULL,
    IsActive        BIT                         NOT NULL DEFAULT 1,
    CreatedAt       DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt       DATETIME2                       NULL,
    RowVersion      ROWVERSION                  NOT NULL,
    CONSTRAINT PK_FeatureFlags              PRIMARY KEY (FeatureFlagId),
    CONSTRAINT UQ_FeatureFlags_FeatureFlagName UNIQUE   (FeatureFlagName)
);
GO

CREATE TABLE LogLevels (
    LogLevelId   BIGINT       IDENTITY(1,1) NOT NULL,
    LogLevelName NVARCHAR(20)              NOT NULL,
    CreatedAt    DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_LogLevels PRIMARY KEY (LogLevelId)
);
GO

CREATE TABLE AIAnalysisRequestStatuses (
    AIAnalysisRequestStatusId BIGINT       IDENTITY(1,1) NOT NULL,
    StatusName                NVARCHAR(50)              NOT NULL,
    CreatedAt                 DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_AIAnalysisRequestStatuses PRIMARY KEY (AIAnalysisRequestStatusId)
);
GO

CREATE TABLE AIAnalysisTypes (
    AIAnalysisTypeId BIGINT        IDENTITY(1,1) NOT NULL,
    AnalysisTypeName NVARCHAR(100)               NOT NULL,
    CreatedAt        DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_AIAnalysisTypes PRIMARY KEY (AIAnalysisTypeId)
);
GO

CREATE TABLE AuditActions (
    AuditActionId BIGINT        IDENTITY(1,1) NOT NULL,
    ActionName    NVARCHAR(100)               NOT NULL,
    ActionCode    NVARCHAR(100)               NOT NULL,
    Description   NVARCHAR(500)                   NULL,
    IsActive      BIT                         NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_AuditActions            PRIMARY KEY (AuditActionId),
    CONSTRAINT UQ_AuditActions_ActionCode UNIQUE      (ActionCode)
);
GO

CREATE TABLE AuditEntities (
    AuditEntityId BIGINT        IDENTITY(1,1) NOT NULL,
    EntityName    NVARCHAR(100)               NOT NULL,
    EntityCode    NVARCHAR(100)               NOT NULL,
    Description   NVARCHAR(500)                   NULL,
    IsActive      BIT                         NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_AuditEntities            PRIMARY KEY (AuditEntityId),
    CONSTRAINT UQ_AuditEntities_EntityCode UNIQUE      (EntityCode)
);
GO

CREATE TABLE ManualReviewStatuses (
    ManualReviewStatusId BIGINT       IDENTITY(1,1) NOT NULL,
    StatusName           NVARCHAR(50)              NOT NULL,
    CreatedAt            DATETIME2                 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_ManualReviewStatuses PRIMARY KEY (ManualReviewStatusId)
);
GO

CREATE TABLE Roles (
    RoleId      BIGINT         IDENTITY(1,1) NOT NULL,
    RoleName    NVARCHAR(100)               NOT NULL,
    Description NVARCHAR(300)                   NULL,
    IsActive    BIT                         NOT NULL DEFAULT 1,
    CreatedAt   DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    RowVersion  ROWVERSION                  NOT NULL,
    CONSTRAINT PK_Roles          PRIMARY KEY (RoleId),
    CONSTRAINT UQ_Roles_RoleName UNIQUE      (RoleName)
);
GO

CREATE TABLE Permissions (
    PermissionId   BIGINT         IDENTITY(1,1) NOT NULL,
    PermissionName NVARCHAR(150)               NOT NULL,
    PermissionCode NVARCHAR(150)               NOT NULL,
    Description    NVARCHAR(500)                   NULL,
    IsActive       BIT                         NOT NULL DEFAULT 1,
    CreatedAt      DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    RowVersion     ROWVERSION                  NOT NULL,
    CONSTRAINT PK_Permissions                PRIMARY KEY (PermissionId),
    CONSTRAINT UQ_Permissions_PermissionCode UNIQUE      (PermissionCode)
);
GO

-- ============================================================
-- SECCION 2 — JUGADORES
-- ============================================================

CREATE TABLE Players (
    PlayerId    BIGINT         IDENTITY(1,1) NOT NULL,
    Username    NVARCHAR(30)                NOT NULL,
    Email       NVARCHAR(255)               NOT NULL,
    DisplayName NVARCHAR(100)               NOT NULL,
    CountryId   BIGINT                          NULL,
    IsVerified  BIT                         NOT NULL DEFAULT 0,
    IsActive    BIT                         NOT NULL DEFAULT 1,
    CreatedAt   DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt   DATETIME2                       NULL,
    DeletedAt   DATETIME2                       NULL,
    CONSTRAINT PK_Players          PRIMARY KEY (PlayerId),
    CONSTRAINT UQ_Players_Username UNIQUE      (Username),
    CONSTRAINT UQ_Players_Email    UNIQUE      (Email),
    CONSTRAINT FK_Players_Countries FOREIGN KEY (CountryId)
        REFERENCES Countries (CountryId)
);
GO

CREATE TABLE PlayerProfiles (
    ProfileId           BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId            BIGINT                       NOT NULL,
    Biography           NVARCHAR(500)                    NULL,
    ProfilePictureUrl   NVARCHAR(500)                    NULL,
    BirthDate           DATE                             NULL,
    GenderId            BIGINT                           NULL,
    PreferredLanguageId BIGINT                           NULL,
    CreatedAt           DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2                        NULL,
    CONSTRAINT PK_PlayerProfiles         PRIMARY KEY (ProfileId),
    CONSTRAINT UQ_PlayerProfiles_PlayerId UNIQUE     (PlayerId),
    CONSTRAINT FK_PlayerProfiles_Players  FOREIGN KEY (PlayerId)
        REFERENCES Players   (PlayerId),
    CONSTRAINT FK_PlayerProfiles_Genders  FOREIGN KEY (GenderId)
        REFERENCES Genders   (GenderId),
    CONSTRAINT FK_PlayerProfiles_Languages FOREIGN KEY (PreferredLanguageId)
        REFERENCES Languages (LanguageId)
);
GO

CREATE TABLE PlayerSettings (
    SettingId               BIGINT IDENTITY(1,1) NOT NULL,
    PlayerId                BIGINT               NOT NULL,
    IsProfilePublic         BIT                  NOT NULL DEFAULT 1,
    AllowTaggedPropositions BIT                  NOT NULL DEFAULT 1,
    AllowNotifications      BIT                  NOT NULL DEFAULT 1,
    AllowEmailNotifications BIT                  NOT NULL DEFAULT 1,
    AllowMoneyPredictions   BIT                  NOT NULL DEFAULT 0,
    CreatedAt               DATETIME2            NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt               DATETIME2                NULL,
    CONSTRAINT PK_PlayerSettings         PRIMARY KEY (SettingId),
    CONSTRAINT UQ_PlayerSettings_PlayerId UNIQUE     (PlayerId),
    CONSTRAINT FK_PlayerSettings_Players  FOREIGN KEY (PlayerId)
        REFERENCES Players (PlayerId)
);
GO

CREATE TABLE PlayerSocialAccounts (
    SocialAccountId  BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId         BIGINT                       NOT NULL,
    PlatformId       BIGINT                       NOT NULL,
    SocialUsername   NVARCHAR(100)                NOT NULL,
    SocialProfileUrl NVARCHAR(500)                    NULL,
    AccessToken      NVARCHAR(1000)                   NULL,
    RefreshToken     NVARCHAR(1000)                   NULL,
    IsVerified       BIT                          NOT NULL DEFAULT 0,
    ConnectedAt      DATETIME2                        NULL,
    LastSyncAt       DATETIME2                        NULL,
    CONSTRAINT PK_PlayerSocialAccounts                   PRIMARY KEY (SocialAccountId),
    CONSTRAINT UQ_PlayerSocialAccounts_PlayerPlatform    UNIQUE      (PlayerId, PlatformId),
    CONSTRAINT FK_PlayerSocialAccounts_Players           FOREIGN KEY (PlayerId)
        REFERENCES Players        (PlayerId),
    CONSTRAINT FK_PlayerSocialAccounts_SocialPlatforms   FOREIGN KEY (PlatformId)
        REFERENCES SocialPlatforms (PlatformId)
);
GO

CREATE TABLE SocialVerifications (
    VerificationId             BIGINT    IDENTITY(1,1) NOT NULL,
    SocialAccountId            BIGINT                  NOT NULL,
    SocialVerificationMethodId BIGINT                  NOT NULL,
    SocialVerificationStatusId BIGINT                  NOT NULL,
    VerifiedAt                 DATETIME2                   NULL,
    CreatedAt                  DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SocialVerifications PRIMARY KEY (VerificationId),
    CONSTRAINT FK_SocialVerifications_PlayerSocialAccounts       FOREIGN KEY (SocialAccountId)
        REFERENCES PlayerSocialAccounts       (SocialAccountId),
    CONSTRAINT FK_SocialVerifications_SocialVerificationMethods  FOREIGN KEY (SocialVerificationMethodId)
        REFERENCES SocialVerificationMethods  (SocialVerificationMethodId),
    CONSTRAINT FK_SocialVerifications_SocialVerificationStatuses FOREIGN KEY (SocialVerificationStatusId)
        REFERENCES SocialVerificationStatuses (SocialVerificationStatusId)
);
GO

-- ============================================================
-- SECCION 3 — PROPOSICIONES
-- NOTA: PropositionGroups se crea sin el FK de WinningPropositionId
--       para resolver la dependencia circular con Propositions.
--       El FK se agrega mediante ALTER TABLE al final de esta seccion.
-- ============================================================

CREATE TABLE PropositionGroups (
    EventGroupId              BIGINT    IDENTITY(1,1) NOT NULL,
    TargetPlayerId            BIGINT                  NOT NULL,
    FirstPropositionCreatedAt DATETIME2               NOT NULL,
    VotingDeadline            DATETIME2               NOT NULL,
    WinningPropositionId      BIGINT                      NULL,
    IsVotingClosed            BIT                     NOT NULL DEFAULT 0,
    CreatedAt                 DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt                 DATETIME2                   NULL,
    CONSTRAINT PK_PropositionGroups PRIMARY KEY (EventGroupId),
    CONSTRAINT FK_PropositionGroups_Players FOREIGN KEY (TargetPlayerId)
        REFERENCES Players (PlayerId)
    -- FK_PropositionGroups_WinningPropositionId agregado por ALTER TABLE mas abajo
);
GO

CREATE TABLE Propositions (
    PropositionId           BIGINT         IDENTITY(1,1) NOT NULL,
    CreatedByPlayerId       BIGINT                       NOT NULL,
    TargetPlayerId          BIGINT                       NOT NULL,
    StatusId                BIGINT                       NOT NULL,
    TypeId                  BIGINT                       NOT NULL,
    AIValidationStatusId    BIGINT                       NOT NULL,
    EventGroupId            BIGINT                       NOT NULL,
    Title                   NVARCHAR(200)                NOT NULL,
    Description             NVARCHAR(2000)                   NULL,
    EventDate               DATETIME2                        NULL,
    PredictionCloseDate     DATETIME2                        NULL,
    ResolutionDate          DATETIME2                        NULL,
    IsPublic                BIT                          NOT NULL DEFAULT 1,
    RequiresMoneyPrediction BIT                          NOT NULL DEFAULT 0,
    RequiresPointPrediction BIT                          NOT NULL DEFAULT 1,
    CreatedAt               DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt               DATETIME2                        NULL,
    DeletedAt               DATETIME2                        NULL,
    CONSTRAINT PK_Propositions                    PRIMARY KEY (PropositionId),
    CONSTRAINT FK_Propositions_CreatedByPlayer    FOREIGN KEY (CreatedByPlayerId)
        REFERENCES Players             (PlayerId),
    CONSTRAINT FK_Propositions_TargetPlayer       FOREIGN KEY (TargetPlayerId)
        REFERENCES Players             (PlayerId),
    CONSTRAINT FK_Propositions_PropositionStatuses FOREIGN KEY (StatusId)
        REFERENCES PropositionStatuses (StatusId),
    CONSTRAINT FK_Propositions_PropositionTypes   FOREIGN KEY (TypeId)
        REFERENCES PropositionTypes    (TypeId),
    CONSTRAINT FK_Propositions_AIValidationStatuses FOREIGN KEY (AIValidationStatusId)
        REFERENCES AIValidationStatuses  (AIValidationStatusId),
    CONSTRAINT FK_Propositions_PropositionGroups  FOREIGN KEY (EventGroupId)
        REFERENCES PropositionGroups   (EventGroupId)
);
GO

-- Resolucion de la dependencia circular PropositionGroups <-> Propositions
ALTER TABLE PropositionGroups
    ADD CONSTRAINT FK_PropositionGroups_WinningProposition
        FOREIGN KEY (WinningPropositionId)
        REFERENCES Propositions (PropositionId);
GO

CREATE TABLE PropositionVotes (
    VoteId        BIGINT    IDENTITY(1,1) NOT NULL,
    PropositionId BIGINT                  NOT NULL,
    PlayerId      BIGINT                  NOT NULL,
    VoteValue     BIT                     NOT NULL,
    CreatedAt     DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionVotes                        PRIMARY KEY (VoteId),
    CONSTRAINT UQ_PropositionVotes_PropositionPlayer      UNIQUE      (PropositionId, PlayerId),
    CONSTRAINT FK_PropositionVotes_Propositions           FOREIGN KEY (PropositionId)
        REFERENCES Propositions (PropositionId),
    CONSTRAINT FK_PropositionVotes_Players                FOREIGN KEY (PlayerId)
        REFERENCES Players      (PlayerId)
);
GO

CREATE TABLE PropositionAcceptances (
    AcceptanceId    BIGINT         IDENTITY(1,1) NOT NULL,
    PropositionId   BIGINT                       NOT NULL,
    TargetPlayerId  BIGINT                       NOT NULL,
    IsAccepted      BIT                          NOT NULL,
    RejectionReason NVARCHAR(500)                    NULL,
    RespondedAt     DATETIME2                        NULL,
    CreatedAt       DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionAcceptances                    PRIMARY KEY (AcceptanceId),
    CONSTRAINT UQ_PropositionAcceptances_PropositionId      UNIQUE      (PropositionId),
    CONSTRAINT FK_PropositionAcceptances_Propositions       FOREIGN KEY (PropositionId)
        REFERENCES Propositions (PropositionId),
    CONSTRAINT FK_PropositionAcceptances_Players            FOREIGN KEY (TargetPlayerId)
        REFERENCES Players      (PlayerId)
);
GO

CREATE TABLE PropositionClosures (
    ClosureId                  BIGINT    IDENTITY(1,1) NOT NULL,
    PropositionId              BIGINT                  NOT NULL,
    ClosedByPlayerId           BIGINT                  NOT NULL,
    PropositionClosureReasonId BIGINT                  NOT NULL,
    ClosedAt                   DATETIME2                   NULL,
    CreatedAt                  DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionClosures                           PRIMARY KEY (ClosureId),
    CONSTRAINT FK_PropositionClosures_Propositions              FOREIGN KEY (PropositionId)
        REFERENCES Propositions              (PropositionId),
    CONSTRAINT FK_PropositionClosures_Players                   FOREIGN KEY (ClosedByPlayerId)
        REFERENCES Players                   (PlayerId),
    CONSTRAINT FK_PropositionClosures_PropositionClosureReasons FOREIGN KEY (PropositionClosureReasonId)
        REFERENCES PropositionClosureReasons (PropositionClosureReasonId)
);
GO

CREATE TABLE PropositionResults (
    ResultId                  BIGINT       IDENTITY(1,1) NOT NULL,
    PropositionId             BIGINT                     NOT NULL,
    WinningPredictionOptionId BIGINT                     NOT NULL,
    WasSuccessful             BIT                        NOT NULL,
    AIConfidenceScore         DECIMAL(5,2)                   NULL,
    ManualReviewRequired      BIT                        NOT NULL DEFAULT 0,
    ResolutionSummary         NVARCHAR(1000)                 NULL,
    ResolvedAt                DATETIME2                      NULL,
    CreatedAt                 DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionResults                          PRIMARY KEY (ResultId),
    CONSTRAINT FK_PropositionResults_Propositions             FOREIGN KEY (PropositionId)
        REFERENCES Propositions            (PropositionId),
    CONSTRAINT FK_PropositionResults_WinningPredictionOptions FOREIGN KEY (WinningPredictionOptionId)
        REFERENCES WinningPredictionOptions (WinningPredictionOptionId)
);
GO

CREATE TABLE PropositionDisputes (
    DisputeId                  BIGINT         IDENTITY(1,1) NOT NULL,
    PropositionId              BIGINT                       NOT NULL,
    CreatedByPlayerId          BIGINT                       NOT NULL,
    PropositionDisputeStatusId BIGINT                       NOT NULL,
    DisputeReason              NVARCHAR(1000)                   NULL,
    ResolutionNotes            NVARCHAR(1000)                   NULL,
    CreatedAt                  DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    ResolvedAt                 DATETIME2                        NULL,
    CONSTRAINT PK_PropositionDisputes                              PRIMARY KEY (DisputeId),
    CONSTRAINT FK_PropositionDisputes_Propositions                 FOREIGN KEY (PropositionId)
        REFERENCES Propositions              (PropositionId),
    CONSTRAINT FK_PropositionDisputes_Players                      FOREIGN KEY (CreatedByPlayerId)
        REFERENCES Players                   (PlayerId),
    CONSTRAINT FK_PropositionDisputes_PropositionDisputeStatuses   FOREIGN KEY (PropositionDisputeStatusId)
        REFERENCES PropositionDisputeStatuses (PropositionDisputeStatusId)
);
GO

CREATE TABLE PropositionTags (
    PropositionTagId BIGINT    IDENTITY(1,1) NOT NULL,
    PropositionId    BIGINT                  NOT NULL,
    TagId            BIGINT                  NOT NULL,
    CreatedAt        DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionTags                   PRIMARY KEY (PropositionTagId),
    CONSTRAINT UQ_PropositionTags_PropositionTag    UNIQUE      (PropositionId, TagId),
    CONSTRAINT FK_PropositionTags_Propositions      FOREIGN KEY (PropositionId)
        REFERENCES Propositions (PropositionId),
    CONSTRAINT FK_PropositionTags_Tags              FOREIGN KEY (TagId)
        REFERENCES Tags         (TagId)
);
GO

-- ============================================================
-- SECCION 4 — PREDICCIONES
-- ============================================================

CREATE TABLE Predictions (
    PredictionId        BIGINT    IDENTITY(1,1) NOT NULL,
    PropositionId       BIGINT                  NOT NULL,
    PlayerId            BIGINT                  NOT NULL,
    PredictionStatusId  BIGINT                  NOT NULL,
    PredictionOutcomeId BIGINT                      NULL,
    PredictionValue     BIT                     NOT NULL,
    IsPointPrediction   BIT                     NOT NULL DEFAULT 0,
    IsMoneyPrediction   BIT                     NOT NULL DEFAULT 0,
    CreatedAt           DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2                   NULL,
    ClosedAt            DATETIME2                   NULL,
    CONSTRAINT PK_Predictions                    PRIMARY KEY (PredictionId),
    CONSTRAINT FK_Predictions_Propositions       FOREIGN KEY (PropositionId)
        REFERENCES Propositions      (PropositionId),
    CONSTRAINT FK_Predictions_Players            FOREIGN KEY (PlayerId)
        REFERENCES Players           (PlayerId),
    CONSTRAINT FK_Predictions_PredictionStatuses FOREIGN KEY (PredictionStatusId)
        REFERENCES PredictionStatuses (PredictionStatusId),
    CONSTRAINT FK_Predictions_PredictionOutcomes FOREIGN KEY (PredictionOutcomeId)
        REFERENCES PredictionOutcomes (PredictionOutcomeId)
);
GO

CREATE TABLE PredictionPointBets (
    PointBetId               BIGINT IDENTITY(1,1) NOT NULL,
    PredictionId             BIGINT               NOT NULL,
    PointsAmount             INT                  NOT NULL,
    PointsWon                INT                      NULL,
    PlatformCommissionPoints INT                      NULL,
    CreatorCommissionPoints  INT                      NULL,
    CreatedAt                DATETIME2            NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PredictionPointBets             PRIMARY KEY (PointBetId),
    CONSTRAINT FK_PredictionPointBets_Predictions FOREIGN KEY (PredictionId)
        REFERENCES Predictions (PredictionId)
);
GO

CREATE TABLE PredictionMoneyBets (
    MoneyBetId              BIGINT        IDENTITY(1,1) NOT NULL,
    PredictionId            BIGINT                     NOT NULL,
    CurrencyId              BIGINT                     NOT NULL,
    MoneyAmount             DECIMAL(18,2)              NOT NULL,
    MoneyWon                DECIMAL(18,2)                  NULL,
    PlatformCommissionMoney DECIMAL(18,2)                  NULL,
    CreatorCommissionMoney  DECIMAL(18,2)                  NULL,
    CreatedAt               DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt               DATETIME2                      NULL,
    CONSTRAINT PK_PredictionMoneyBets             PRIMARY KEY (MoneyBetId),
    CONSTRAINT FK_PredictionMoneyBets_Predictions FOREIGN KEY (PredictionId)
        REFERENCES Predictions (PredictionId),
    CONSTRAINT FK_PredictionMoneyBets_Currencies  FOREIGN KEY (CurrencyId)
        REFERENCES Currencies  (CurrencyId)
);
GO

CREATE TABLE PredictionAdjustments (
    AdjustmentId                 BIGINT        IDENTITY(1,1) NOT NULL,
    PredictionId                 BIGINT                     NOT NULL,
    PredictionAdjustmentReasonId BIGINT                     NOT NULL,
    CurrencyId                   BIGINT                     NOT NULL,
    PreviousAmount               DECIMAL(18,2)              NOT NULL,
    NewAmount                    DECIMAL(18,2)              NOT NULL,
    AdjustedAt                   DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PredictionAdjustments                          PRIMARY KEY (AdjustmentId),
    CONSTRAINT FK_PredictionAdjustments_Predictions              FOREIGN KEY (PredictionId)
        REFERENCES Predictions                (PredictionId),
    CONSTRAINT FK_PredictionAdjustments_PredictionAdjustmentReasons FOREIGN KEY (PredictionAdjustmentReasonId)
        REFERENCES PredictionAdjustmentReasons (PredictionAdjustmentReasonId),
    CONSTRAINT FK_PredictionAdjustments_Currencies               FOREIGN KEY (CurrencyId)
        REFERENCES Currencies                  (CurrencyId)
);
GO

-- ============================================================
-- SECCION 5 — EVIDENCIA
-- ============================================================

CREATE TABLE EvidenceSubmissions (
    EvidenceSubmissionId       BIGINT         IDENTITY(1,1) NOT NULL,
    PropositionId              BIGINT                       NOT NULL,
    SubmittedByPlayerId        BIGINT                       NOT NULL,
    EvidenceTypeId             BIGINT                       NOT NULL,
    EvidenceSubmissionStatusId BIGINT                       NOT NULL,
    SubmissionNotes            NVARCHAR(1000)                   NULL,
    SubmittedAt                DATETIME2                        NULL,
    CreatedAt                  DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EvidenceSubmissions                              PRIMARY KEY (EvidenceSubmissionId),
    CONSTRAINT FK_EvidenceSubmissions_Propositions                 FOREIGN KEY (PropositionId)
        REFERENCES Propositions              (PropositionId),
    CONSTRAINT FK_EvidenceSubmissions_Players                      FOREIGN KEY (SubmittedByPlayerId)
        REFERENCES Players                   (PlayerId),
    CONSTRAINT FK_EvidenceSubmissions_EvidenceTypes                FOREIGN KEY (EvidenceTypeId)
        REFERENCES EvidenceTypes             (EvidenceTypeId),
    CONSTRAINT FK_EvidenceSubmissions_EvidenceSubmissionStatuses   FOREIGN KEY (EvidenceSubmissionStatusId)
        REFERENCES EvidenceSubmissionStatuses (EvidenceSubmissionStatusId)
);
GO

CREATE TABLE EvidenceFiles (
    EvidenceFileId       BIGINT         IDENTITY(1,1) NOT NULL,
    EvidenceSubmissionId BIGINT                       NOT NULL,
    FileTypeId           BIGINT                       NOT NULL,
    FileUrl              NVARCHAR(500)                NOT NULL,
    FileSize             BIGINT                           NULL,
    MimeType             NVARCHAR(100)                    NULL,
    UploadedAt           DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EvidenceFiles                        PRIMARY KEY (EvidenceFileId),
    CONSTRAINT FK_EvidenceFiles_EvidenceSubmissions    FOREIGN KEY (EvidenceSubmissionId)
        REFERENCES EvidenceSubmissions (EvidenceSubmissionId),
    CONSTRAINT FK_EvidenceFiles_FileTypes              FOREIGN KEY (FileTypeId)
        REFERENCES FileTypes           (FileTypeId)
);
GO

CREATE TABLE SocialMediaEvidence (
    EvidenceId         BIGINT         IDENTITY(1,1) NOT NULL,
    PropositionId      BIGINT                       NOT NULL,
    UploadedByPlayerId BIGINT                       NOT NULL,
    PlatformId         BIGINT                       NOT NULL,
    MediaTypeId        BIGINT                       NOT NULL,
    MediaUrl           NVARCHAR(500)                NOT NULL,
    Caption            NVARCHAR(1000)                   NULL,
    Hashtags           NVARCHAR(500)                    NULL,
    PostedAt           DATETIME2                        NULL,
    CreatedAt          DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_SocialMediaEvidence                   PRIMARY KEY (EvidenceId),
    CONSTRAINT FK_SocialMediaEvidence_Propositions      FOREIGN KEY (PropositionId)
        REFERENCES Propositions   (PropositionId),
    CONSTRAINT FK_SocialMediaEvidence_Players           FOREIGN KEY (UploadedByPlayerId)
        REFERENCES Players        (PlayerId),
    CONSTRAINT FK_SocialMediaEvidence_SocialPlatforms   FOREIGN KEY (PlatformId)
        REFERENCES SocialPlatforms (PlatformId),
    CONSTRAINT FK_SocialMediaEvidence_MediaTypes        FOREIGN KEY (MediaTypeId)
        REFERENCES MediaTypes      (MediaTypeId)
);
GO

CREATE TABLE EvidenceValidations (
    ValidationId               BIGINT        IDENTITY(1,1) NOT NULL,
    EvidenceSubmissionId       BIGINT                     NOT NULL,
    EvidenceValidationStatusId BIGINT                     NOT NULL,
    AIConfidenceScore          DECIMAL(5,2)                   NULL,
    RequiresManualReview       BIT                        NOT NULL DEFAULT 0,
    ValidationNotes            NVARCHAR(1000)                 NULL,
    ValidatedAt                DATETIME2                      NULL,
    CreatedAt                  DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_EvidenceValidations                              PRIMARY KEY (ValidationId),
    CONSTRAINT FK_EvidenceValidations_EvidenceSubmissions          FOREIGN KEY (EvidenceSubmissionId)
        REFERENCES EvidenceSubmissions        (EvidenceSubmissionId),
    CONSTRAINT FK_EvidenceValidations_EvidenceValidationStatuses   FOREIGN KEY (EvidenceValidationStatusId)
        REFERENCES EvidenceValidationStatuses (EvidenceValidationStatusId)
);
GO

-- ============================================================
-- SECCION 6 — EVENT SOURCING
-- ============================================================

CREATE TABLE GameEvents (
    GameEventId       BIGINT         IDENTITY(1,1) NOT NULL,
    EventTypeId       BIGINT                       NOT NULL,
    EventSourceId     BIGINT                       NOT NULL,
    EntityTypeId      BIGINT                       NOT NULL,
    RelatedEntityId   BIGINT                           NULL,
    EventData         NVARCHAR(MAX)                    NULL,
    CreatedByPlayerId BIGINT                           NULL,
    CreatedAt         DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_GameEvents              PRIMARY KEY (GameEventId),
    CONSTRAINT FK_GameEvents_EventTypes   FOREIGN KEY (EventTypeId)
        REFERENCES EventTypes   (EventTypeId),
    CONSTRAINT FK_GameEvents_EventSources FOREIGN KEY (EventSourceId)
        REFERENCES EventSources (EventSourceId),
    CONSTRAINT FK_GameEvents_EntityTypes  FOREIGN KEY (EntityTypeId)
        REFERENCES EntityTypes  (EntityTypeId),
    CONSTRAINT FK_GameEvents_Players      FOREIGN KEY (CreatedByPlayerId)
        REFERENCES Players      (PlayerId)
);
GO

CREATE TABLE PlayerEvents (
    PlayerEventId    BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId         BIGINT                       NOT NULL,
    EventTypeId      BIGINT                       NOT NULL,
    EventDescription NVARCHAR(1000)                   NULL,
    EventData        NVARCHAR(MAX)                    NULL,
    CreatedAt        DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PlayerEvents             PRIMARY KEY (PlayerEventId),
    CONSTRAINT FK_PlayerEvents_Players     FOREIGN KEY (PlayerId)
        REFERENCES Players    (PlayerId),
    CONSTRAINT FK_PlayerEvents_EventTypes  FOREIGN KEY (EventTypeId)
        REFERENCES EventTypes (EventTypeId)
);
GO

CREATE TABLE PropositionEvents (
    PropositionEventId  BIGINT         IDENTITY(1,1) NOT NULL,
    PropositionId       BIGINT                       NOT NULL,
    EventTypeId         BIGINT                       NOT NULL,
    EventDescription    NVARCHAR(1000)                   NULL,
    EventData           NVARCHAR(MAX)                    NULL,
    TriggeredByPlayerId BIGINT                           NULL,
    CreatedAt           DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PropositionEvents              PRIMARY KEY (PropositionEventId),
    CONSTRAINT FK_PropositionEvents_Propositions FOREIGN KEY (PropositionId)
        REFERENCES Propositions (PropositionId),
    CONSTRAINT FK_PropositionEvents_EventTypes   FOREIGN KEY (EventTypeId)
        REFERENCES EventTypes   (EventTypeId),
    CONSTRAINT FK_PropositionEvents_Players      FOREIGN KEY (TriggeredByPlayerId)
        REFERENCES Players      (PlayerId)
);
GO

CREATE TABLE PredictionEvents (
    PredictionEventId   BIGINT         IDENTITY(1,1) NOT NULL,
    PredictionId        BIGINT                       NOT NULL,
    EventTypeId         BIGINT                       NOT NULL,
    EventDescription    NVARCHAR(1000)                   NULL,
    EventData           NVARCHAR(MAX)                    NULL,
    TriggeredByPlayerId BIGINT                           NULL,
    CreatedAt           DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_PredictionEvents              PRIMARY KEY (PredictionEventId),
    CONSTRAINT FK_PredictionEvents_Predictions  FOREIGN KEY (PredictionId)
        REFERENCES Predictions (PredictionId),
    CONSTRAINT FK_PredictionEvents_EventTypes   FOREIGN KEY (EventTypeId)
        REFERENCES EventTypes  (EventTypeId),
    CONSTRAINT FK_PredictionEvents_Players      FOREIGN KEY (TriggeredByPlayerId)
        REFERENCES Players     (PlayerId)
);
GO

-- ============================================================
-- SECCION 7 — WALLETS Y FINANZAS
-- ============================================================

CREATE TABLE Wallets (
    WalletId       BIGINT        IDENTITY(1,1) NOT NULL,
    PlayerId       BIGINT                      NOT NULL,
    WalletTypeId   BIGINT                      NOT NULL,
    CurrencyId     BIGINT                      NOT NULL,
    CurrentBalance DECIMAL(19,4)               NOT NULL DEFAULT 0,
    IsBlocked      BIT                         NOT NULL DEFAULT 0,
    IsActive       BIT                         NOT NULL DEFAULT 1,
    CreatedAt      DATETIME2                   NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt      DATETIME2                       NULL,
    RowVersion     ROWVERSION                  NOT NULL,
    CONSTRAINT PK_Wallets                    PRIMARY KEY (WalletId),
    CONSTRAINT UQ_Wallets_PlayerWalletType   UNIQUE      (PlayerId, WalletTypeId),
    CONSTRAINT FK_Wallets_Players            FOREIGN KEY (PlayerId)
        REFERENCES Players     (PlayerId),
    CONSTRAINT FK_Wallets_WalletTypes        FOREIGN KEY (WalletTypeId)
        REFERENCES WalletTypes (WalletTypeId),
    CONSTRAINT FK_Wallets_Currencies         FOREIGN KEY (CurrencyId)
        REFERENCES Currencies  (CurrencyId)
);
GO

CREATE TABLE WalletTransactions (
    WalletTransactionId     BIGINT        IDENTITY(1,1) NOT NULL,
    WalletId                BIGINT                     NOT NULL,
    WalletTransactionTypeId BIGINT                     NOT NULL,
    WalletBalanceFormatId   BIGINT                     NOT NULL,
    Amount                  DECIMAL(19,4)              NOT NULL,
    PreviousBalance         DECIMAL(19,4)              NOT NULL,
    NewBalance              DECIMAL(19,4)              NOT NULL,
    Reference               NVARCHAR(100)                  NULL,
    ObjectSource            NVARCHAR(50)                   NULL,
    ReferenceId             BIGINT                         NULL,
    Description             NVARCHAR(500)                  NULL,
    TransactionDate         DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CreatedByPlayerId       BIGINT                         NULL,
    Checksum                BINARY(16)                     NULL,
    CONSTRAINT PK_WalletTransactions                        PRIMARY KEY (WalletTransactionId),
    CONSTRAINT FK_WalletTransactions_Wallets                FOREIGN KEY (WalletId)
        REFERENCES Wallets                 (WalletId),
    CONSTRAINT FK_WalletTransactions_WalletTransactionTypes FOREIGN KEY (WalletTransactionTypeId)
        REFERENCES WalletTransactionTypes  (WalletTransactionTypeId),
    CONSTRAINT FK_WalletTransactions_WalletBalanceFormats   FOREIGN KEY (WalletBalanceFormatId)
        REFERENCES WalletBalanceFormats    (WalletBalanceFormatId),
    CONSTRAINT FK_WalletTransactions_Players                FOREIGN KEY (CreatedByPlayerId)
        REFERENCES Players                 (PlayerId)
);
GO

CREATE TABLE FinancialMovements (
    FinancialMovementId     BIGINT        IDENTITY(1,1) NOT NULL,
    PlayerId                BIGINT                     NOT NULL,
    WalletId                BIGINT                     NOT NULL,
    PaymentMethodId         BIGINT                     NOT NULL,
    PaymentStatusId         BIGINT                     NOT NULL,
    CurrencyId              BIGINT                     NOT NULL,
    FinancialMovementTypeId BIGINT                     NOT NULL,
    Amount                  DECIMAL(19,4)              NOT NULL,
    CommissionAmount        DECIMAL(19,4)                  NULL,
    ExternalReference       NVARCHAR(200)                  NULL,
    GatewayResponse         NVARCHAR(2000)                 NULL,
    ObjectSource            NVARCHAR(50)                   NULL,
    ReferenceId             BIGINT                         NULL,
    MovementDate            DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    ProcessedByPlayerId     BIGINT                         NULL,
    Checksum                BINARY(16)                     NULL,
    CONSTRAINT PK_FinancialMovements                        PRIMARY KEY (FinancialMovementId),
    CONSTRAINT FK_FinancialMovements_Players                FOREIGN KEY (PlayerId)
        REFERENCES Players               (PlayerId),
    CONSTRAINT FK_FinancialMovements_Wallets                FOREIGN KEY (WalletId)
        REFERENCES Wallets               (WalletId),
    CONSTRAINT FK_FinancialMovements_PaymentMethods         FOREIGN KEY (PaymentMethodId)
        REFERENCES PaymentMethods        (PaymentMethodId),
    CONSTRAINT FK_FinancialMovements_PaymentStatuses        FOREIGN KEY (PaymentStatusId)
        REFERENCES PaymentStatuses       (PaymentStatusId),
    CONSTRAINT FK_FinancialMovements_Currencies             FOREIGN KEY (CurrencyId)
        REFERENCES Currencies            (CurrencyId),
    CONSTRAINT FK_FinancialMovements_FinancialMovementTypes FOREIGN KEY (FinancialMovementTypeId)
        REFERENCES FinancialMovementTypes (FinancialMovementTypeId),
    CONSTRAINT FK_FinancialMovements_ProcessedByPlayer      FOREIGN KEY (ProcessedByPlayerId)
        REFERENCES Players               (PlayerId)
);
GO

CREATE TABLE PointPurchases (
    PointPurchaseId   BIGINT        IDENTITY(1,1) NOT NULL,
    PlayerId          BIGINT                     NOT NULL,
    WalletId          BIGINT                     NOT NULL,
    PaymentMethodId   BIGINT                     NOT NULL,
    PaymentStatusId   BIGINT                     NOT NULL,
    CurrencyId        BIGINT                     NOT NULL,
    PointsAmount      INT                        NOT NULL,
    AmountPaid        DECIMAL(19,4)              NOT NULL,
    ExternalReference NVARCHAR(200)                  NULL,
    PurchaseDate      DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CreatedAt         DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    Checksum          BINARY(16)                     NULL,
    CONSTRAINT PK_PointPurchases                 PRIMARY KEY (PointPurchaseId),
    CONSTRAINT FK_PointPurchases_Players         FOREIGN KEY (PlayerId)
        REFERENCES Players        (PlayerId),
    CONSTRAINT FK_PointPurchases_Wallets         FOREIGN KEY (WalletId)
        REFERENCES Wallets        (WalletId),
    CONSTRAINT FK_PointPurchases_PaymentMethods  FOREIGN KEY (PaymentMethodId)
        REFERENCES PaymentMethods  (PaymentMethodId),
    CONSTRAINT FK_PointPurchases_PaymentStatuses FOREIGN KEY (PaymentStatusId)
        REFERENCES PaymentStatuses (PaymentStatusId),
    CONSTRAINT FK_PointPurchases_Currencies      FOREIGN KEY (CurrencyId)
        REFERENCES Currencies      (CurrencyId)
);
GO

CREATE TABLE PlatformCommissions (
    PlatformCommissionId BIGINT        IDENTITY(1,1) NOT NULL,
    BeneficiaryPlayerId  BIGINT                          NULL,
    SourcePlayerId       BIGINT                          NULL,
    WalletId             BIGINT                          NULL,
    CommissionPercentage DECIMAL(5,2)                    NULL,
    CommissionAmount     DECIMAL(19,4)              NOT NULL,
    ObjectSource         NVARCHAR(50)                    NULL,
    ReferenceId          BIGINT                          NULL,
    Description          NVARCHAR(500)                   NULL,
    CommissionDate       DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    Checksum             BINARY(16)                      NULL,
    CONSTRAINT PK_PlatformCommissions                    PRIMARY KEY (PlatformCommissionId),
    CONSTRAINT FK_PlatformCommissions_BeneficiaryPlayer  FOREIGN KEY (BeneficiaryPlayerId)
        REFERENCES Players (PlayerId),
    CONSTRAINT FK_PlatformCommissions_SourcePlayer       FOREIGN KEY (SourcePlayerId)
        REFERENCES Players (PlayerId),
    CONSTRAINT FK_PlatformCommissions_Wallets            FOREIGN KEY (WalletId)
        REFERENCES Wallets (WalletId)
);
GO

-- ============================================================
-- SECCION 8 — AFILIADOS
-- ============================================================

CREATE TABLE AffiliatePartners (
    AffiliatePartnerId BIGINT         IDENTITY(1,1) NOT NULL,
    CountryId          BIGINT                       NOT NULL,
    PartnerName        NVARCHAR(200)                NOT NULL,
    ContactEmail       NVARCHAR(255)                    NULL,
    WebsiteUrl         NVARCHAR(500)                    NULL,
    IsActive           BIT                          NOT NULL DEFAULT 1,
    CreatedAt          DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt          DATETIME2                        NULL,
    CONSTRAINT PK_AffiliatePartners                  PRIMARY KEY (AffiliatePartnerId),
    CONSTRAINT UQ_AffiliatePartners_NameCountry      UNIQUE      (PartnerName, CountryId),
    CONSTRAINT FK_AffiliatePartners_Countries        FOREIGN KEY (CountryId)
        REFERENCES Countries (CountryId)
);
GO

CREATE TABLE AffiliateRewards (
    AffiliateRewardId  BIGINT         IDENTITY(1,1) NOT NULL,
    AffiliatePartnerId BIGINT                       NOT NULL,
    RewardName         NVARCHAR(200)                NOT NULL,
    Description        NVARCHAR(500)                    NULL,
    PointsCost         INT                          NOT NULL,
    Stock              INT                              NULL,
    ExpiresAt          DATETIME2                        NULL,
    IsActive           BIT                          NOT NULL DEFAULT 1,
    CreatedAt          DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt          DATETIME2                        NULL,
    CONSTRAINT PK_AffiliateRewards                       PRIMARY KEY (AffiliateRewardId),
    CONSTRAINT UQ_AffiliateRewards_PartnerRewardName     UNIQUE      (AffiliatePartnerId, RewardName),
    CONSTRAINT FK_AffiliateRewards_AffiliatePartners     FOREIGN KEY (AffiliatePartnerId)
        REFERENCES AffiliatePartners (AffiliatePartnerId)
);
GO

CREATE TABLE PointRedemptions (
    PointRedemptionId BIGINT    IDENTITY(1,1) NOT NULL,
    PlayerId          BIGINT                  NOT NULL,
    WalletId          BIGINT                  NOT NULL,
    AffiliateRewardId BIGINT                  NOT NULL,
    PointsSpent       INT                     NOT NULL,
    RedeemedAt        DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    CreatedAt         DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    Checksum          BINARY(16)                  NULL,
    CONSTRAINT PK_PointRedemptions                   PRIMARY KEY (PointRedemptionId),
    CONSTRAINT FK_PointRedemptions_Players           FOREIGN KEY (PlayerId)
        REFERENCES Players          (PlayerId),
    CONSTRAINT FK_PointRedemptions_Wallets           FOREIGN KEY (WalletId)
        REFERENCES Wallets          (WalletId),
    CONSTRAINT FK_PointRedemptions_AffiliateRewards  FOREIGN KEY (AffiliateRewardId)
        REFERENCES AffiliateRewards (AffiliateRewardId)
);
GO

-- ============================================================
-- SECCION 9 — AUTENTICACION Y SEGURIDAD
-- ============================================================

CREATE TABLE AuthenticationCredentials (
    CredentialId        BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId            BIGINT                       NOT NULL,
    PasswordHash        NVARCHAR(500)                NOT NULL,
    PasswordSalt        NVARCHAR(500)                NOT NULL,
    LastLoginAt         DATETIME2                        NULL,
    IsTemporaryPassword BIT                          NOT NULL DEFAULT 0,
    IsBlocked           BIT                          NOT NULL DEFAULT 0,
    IsActive            BIT                          NOT NULL DEFAULT 1,
    CreatedAt           DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt           DATETIME2                        NULL,
    RowVersion          ROWVERSION                   NOT NULL,
    CONSTRAINT PK_AuthenticationCredentials              PRIMARY KEY (CredentialId),
    CONSTRAINT UQ_AuthenticationCredentials_PlayerId     UNIQUE      (PlayerId),
    CONSTRAINT FK_AuthenticationCredentials_Players      FOREIGN KEY (PlayerId)
        REFERENCES Players (PlayerId)
);
GO

CREATE TABLE PasswordHistory (
    PasswordHistoryId BIGINT         IDENTITY(1,1) NOT NULL,
    CredentialId      BIGINT                       NOT NULL,
    PasswordHash      NVARCHAR(500)                NOT NULL,
    ChangedAt         DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    CreatedByPlayerId BIGINT                           NULL,
    CONSTRAINT PK_PasswordHistory                            PRIMARY KEY (PasswordHistoryId),
    CONSTRAINT FK_PasswordHistory_AuthenticationCredentials  FOREIGN KEY (CredentialId)
        REFERENCES AuthenticationCredentials (CredentialId),
    CONSTRAINT FK_PasswordHistory_Players                    FOREIGN KEY (CreatedByPlayerId)
        REFERENCES Players                   (PlayerId)
);
GO

CREATE TABLE LoginAttempts (
    LoginAttemptId BIGINT       IDENTITY(1,1) NOT NULL,
    CredentialId   BIGINT                     NOT NULL,
    IpAddress      NVARCHAR(45)                   NULL,
    UserAgent      NVARCHAR(500)                  NULL,
    WasSuccessful  BIT                        NOT NULL,
    AttemptedAt    DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    CountryId      BIGINT                         NULL,
    Checksum       BINARY(16)                     NULL,
    CONSTRAINT PK_LoginAttempts                            PRIMARY KEY (LoginAttemptId),
    CONSTRAINT FK_LoginAttempts_AuthenticationCredentials  FOREIGN KEY (CredentialId)
        REFERENCES AuthenticationCredentials (CredentialId),
    CONSTRAINT FK_LoginAttempts_Countries                  FOREIGN KEY (CountryId)
        REFERENCES Countries                 (CountryId)
);
GO

CREATE TABLE RefreshTokens (
    RefreshTokenId BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId       BIGINT                       NOT NULL,
    TokenHash      NVARCHAR(500)                NOT NULL,
    IsRevoked      BIT                          NOT NULL DEFAULT 0,
    ExpiresAt      DATETIME2                    NOT NULL,
    RevokedAt      DATETIME2                        NULL,
    CreatedAt      DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    Checksum       BINARY(16)                       NULL,
    CONSTRAINT PK_RefreshTokens         PRIMARY KEY (RefreshTokenId),
    CONSTRAINT FK_RefreshTokens_Players FOREIGN KEY (PlayerId)
        REFERENCES Players (PlayerId)
);
GO

CREATE TABLE AuthenticationSessions (
    AuthenticationSessionId BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId                BIGINT                       NOT NULL,
    RefreshTokenId          BIGINT                       NOT NULL,
    IpAddress               NVARCHAR(45)                     NULL,
    UserAgent               NVARCHAR(500)                    NULL,
    StartedAt               DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    ExpiresAt               DATETIME2                    NOT NULL,
    ClosedAt                DATETIME2                        NULL,
    IsActive                BIT                          NOT NULL DEFAULT 1,
    RowVersion              ROWVERSION                   NOT NULL,
    CONSTRAINT PK_AuthenticationSessions                  PRIMARY KEY (AuthenticationSessionId),
    CONSTRAINT FK_AuthenticationSessions_Players          FOREIGN KEY (PlayerId)
        REFERENCES Players      (PlayerId),
    CONSTRAINT FK_AuthenticationSessions_RefreshTokens    FOREIGN KEY (RefreshTokenId)
        REFERENCES RefreshTokens (RefreshTokenId)
);
GO

CREATE TABLE RolePermissions (
    RolePermissionId BIGINT    IDENTITY(1,1) NOT NULL,
    RoleId           BIGINT                  NOT NULL,
    PermissionId     BIGINT                  NOT NULL,
    CreatedAt        DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT PK_RolePermissions                   PRIMARY KEY (RolePermissionId),
    CONSTRAINT UQ_RolePermissions_RolePermission    UNIQUE      (RoleId, PermissionId),
    CONSTRAINT FK_RolePermissions_Roles             FOREIGN KEY (RoleId)
        REFERENCES Roles       (RoleId),
    CONSTRAINT FK_RolePermissions_Permissions       FOREIGN KEY (PermissionId)
        REFERENCES Permissions (PermissionId)
);
GO

CREATE TABLE PlayerRoles (
    PlayerRoleId       BIGINT    IDENTITY(1,1) NOT NULL,
    PlayerId           BIGINT                  NOT NULL,
    RoleId             BIGINT                  NOT NULL,
    AssignedAt         DATETIME2               NOT NULL DEFAULT GETUTCDATE(),
    AssignedByPlayerId BIGINT                      NULL,
    CONSTRAINT PK_PlayerRoles                    PRIMARY KEY (PlayerRoleId),
    CONSTRAINT UQ_PlayerRoles_PlayerRole         UNIQUE      (PlayerId, RoleId),
    CONSTRAINT FK_PlayerRoles_Players            FOREIGN KEY (PlayerId)
        REFERENCES Players (PlayerId),
    CONSTRAINT FK_PlayerRoles_Roles              FOREIGN KEY (RoleId)
        REFERENCES Roles   (RoleId),
    CONSTRAINT FK_PlayerRoles_AssignedByPlayer   FOREIGN KEY (AssignedByPlayerId)
        REFERENCES Players (PlayerId)
);
GO

-- ============================================================
-- SECCION 10 — AUDITORIA Y NOTIFICACIONES
-- ============================================================

CREATE TABLE AuditLogs (
    AuditLogId    BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId      BIGINT                           NULL,
    AuditActionId BIGINT                       NOT NULL,
    AuditEntityId BIGINT                       NOT NULL,
    ReferenceId   BIGINT                           NULL,
    IpAddress     NVARCHAR(45)                     NULL,
    UserAgent     NVARCHAR(500)                    NULL,
    PreviousValue NVARCHAR(MAX)                    NULL,
    NewValue      NVARCHAR(MAX)                    NULL,
    Observations  NVARCHAR(1000)                   NULL,
    EventDate     DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    Checksum      BINARY(16)                       NULL,
    CONSTRAINT PK_AuditLogs               PRIMARY KEY (AuditLogId),
    CONSTRAINT FK_AuditLogs_Players       FOREIGN KEY (PlayerId)
        REFERENCES Players       (PlayerId),
    CONSTRAINT FK_AuditLogs_AuditActions  FOREIGN KEY (AuditActionId)
        REFERENCES AuditActions  (AuditActionId),
    CONSTRAINT FK_AuditLogs_AuditEntities FOREIGN KEY (AuditEntityId)
        REFERENCES AuditEntities (AuditEntityId)
);
GO

CREATE TABLE Notifications (
    NotificationId     BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId           BIGINT                       NOT NULL,
    NotificationTypeId BIGINT                       NOT NULL,
    Title              NVARCHAR(200)                NOT NULL,
    Message            NVARCHAR(1000)               NOT NULL,
    IsRead             BIT                          NOT NULL DEFAULT 0,
    Priority           TINYINT                      NOT NULL DEFAULT 3,
    ReadAt             DATETIME2                        NULL,
    CreatedAt          DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    RowVersion         ROWVERSION                   NOT NULL,
    CONSTRAINT PK_Notifications                    PRIMARY KEY (NotificationId),
    CONSTRAINT FK_Notifications_Players            FOREIGN KEY (PlayerId)
        REFERENCES Players           (PlayerId),
    CONSTRAINT FK_Notifications_NotificationTypes  FOREIGN KEY (NotificationTypeId)
        REFERENCES NotificationTypes (NotificationTypeId)
);
GO

-- ============================================================
-- SECCION 11 — IA Y MODERACION DE CONTENIDO
-- ============================================================

CREATE TABLE AIAnalysisRequests (
    AIAnalysisRequestId       BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId                  BIGINT                       NOT NULL,
    AIAnalysisTypeId          BIGINT                       NOT NULL,
    AIAnalysisRequestStatusId BIGINT                       NOT NULL,
    ObjectSource              NVARCHAR(50)                     NULL,
    ReferenceId               BIGINT                           NULL,
    AnalyzedContent           NVARCHAR(MAX)                    NULL,
    RequestedAt               DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    ProcessedAt               DATETIME2                        NULL,
    Checksum                  BINARY(16)                       NULL,
    CONSTRAINT PK_AIAnalysisRequests                           PRIMARY KEY (AIAnalysisRequestId),
    CONSTRAINT FK_AIAnalysisRequests_Players                   FOREIGN KEY (PlayerId)
        REFERENCES Players                   (PlayerId),
    CONSTRAINT FK_AIAnalysisRequests_AIAnalysisTypes           FOREIGN KEY (AIAnalysisTypeId)
        REFERENCES AIAnalysisTypes           (AIAnalysisTypeId),
    CONSTRAINT FK_AIAnalysisRequests_AIAnalysisRequestStatuses FOREIGN KEY (AIAnalysisRequestStatusId)
        REFERENCES AIAnalysisRequestStatuses (AIAnalysisRequestStatusId)
);
GO

CREATE TABLE AIAnalysisResults (
    AIAnalysisResultId  BIGINT        IDENTITY(1,1) NOT NULL,
    AIAnalysisRequestId BIGINT                     NOT NULL,
    Result              NVARCHAR(MAX)                  NULL,
    ConfidenceScore     DECIMAL(5,2)                   NULL,
    IsValid             BIT                        NOT NULL DEFAULT 0,
    UsedModel           NVARCHAR(100)                  NULL,
    ProcessingTimeMs    INT                            NULL,
    ResultDate          DATETIME2                  NOT NULL DEFAULT GETUTCDATE(),
    Checksum            BINARY(16)                     NULL,
    CONSTRAINT PK_AIAnalysisResults                     PRIMARY KEY (AIAnalysisResultId),
    CONSTRAINT FK_AIAnalysisResults_AIAnalysisRequests  FOREIGN KEY (AIAnalysisRequestId)
        REFERENCES AIAnalysisRequests (AIAnalysisRequestId)
);
GO

CREATE TABLE ContentModerationResults (
    ContentModerationResultId BIGINT    IDENTITY(1,1) NOT NULL,
    AIAnalysisRequestId       BIGINT                  NOT NULL,
    ContainsViolence          BIT                     NOT NULL DEFAULT 0,
    ContainsDiscrimination    BIT                     NOT NULL DEFAULT 0,
    ContainsFraud             BIT                     NOT NULL DEFAULT 0,
    ContainsSexualContent     BIT                     NOT NULL DEFAULT 0,
    ContainsIllegalContent    BIT                     NOT NULL DEFAULT 0,
    IsApproved                BIT                     NOT NULL DEFAULT 0,
    Observations              NVARCHAR(1000)              NULL,
    ReviewedAt                DATETIME2                   NULL,
    Checksum                  BINARY(16)                  NULL,
    CONSTRAINT PK_ContentModerationResults                     PRIMARY KEY (ContentModerationResultId),
    CONSTRAINT FK_ContentModerationResults_AIAnalysisRequests  FOREIGN KEY (AIAnalysisRequestId)
        REFERENCES AIAnalysisRequests (AIAnalysisRequestId)
);
GO

CREATE TABLE ValidationAttempts (
    ValidationAttemptId BIGINT         IDENTITY(1,1) NOT NULL,
    AIAnalysisRequestId BIGINT                       NOT NULL,
    AttemptNumber       INT                          NOT NULL,
    AttemptResult       NVARCHAR(100)                    NULL,
    Observations        NVARCHAR(1000)                   NULL,
    AttemptedAt         DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    Checksum            BINARY(16)                       NULL,
    CONSTRAINT PK_ValidationAttempts                     PRIMARY KEY (ValidationAttemptId),
    CONSTRAINT FK_ValidationAttempts_AIAnalysisRequests  FOREIGN KEY (AIAnalysisRequestId)
        REFERENCES AIAnalysisRequests (AIAnalysisRequestId)
);
GO

CREATE TABLE ManualReviewCases (
    ManualReviewCaseId   BIGINT         IDENTITY(1,1) NOT NULL,
    AIAnalysisRequestId  BIGINT                       NOT NULL,
    ReviewedByPlayerId   BIGINT                           NULL,
    ManualReviewStatusId BIGINT                       NOT NULL,
    ReviewReason         NVARCHAR(1000)                   NULL,
    Resolution           NVARCHAR(1000)                   NULL,
    AssignedAt           DATETIME2                        NULL,
    ResolvedAt           DATETIME2                        NULL,
    Checksum             BINARY(16)                       NULL,
    CONSTRAINT PK_ManualReviewCases                      PRIMARY KEY (ManualReviewCaseId),
    CONSTRAINT FK_ManualReviewCases_AIAnalysisRequests   FOREIGN KEY (AIAnalysisRequestId)
        REFERENCES AIAnalysisRequests  (AIAnalysisRequestId),
    CONSTRAINT FK_ManualReviewCases_Players              FOREIGN KEY (ReviewedByPlayerId)
        REFERENCES Players             (PlayerId),
    CONSTRAINT FK_ManualReviewCases_ManualReviewStatuses FOREIGN KEY (ManualReviewStatusId)
        REFERENCES ManualReviewStatuses (ManualReviewStatusId)
);
GO

-- ============================================================
-- SECCION 12 — LOGS DE SISTEMA
-- ============================================================

CREATE TABLE SystemLogs (
    SystemLogId BIGINT         IDENTITY(1,1) NOT NULL,
    LogLevelId  BIGINT                       NOT NULL,
    Source      NVARCHAR(100)                    NULL,
    Message     NVARCHAR(2000)               NOT NULL,
    Details     NVARCHAR(MAX)                    NULL,
    IpAddress   NVARCHAR(45)                     NULL,
    EventDate   DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    Checksum    BINARY(16)                       NULL,
    CONSTRAINT PK_SystemLogs            PRIMARY KEY (SystemLogId),
    CONSTRAINT FK_SystemLogs_LogLevels  FOREIGN KEY (LogLevelId)
        REFERENCES LogLevels (LogLevelId)
);
GO

CREATE TABLE ErrorLogs (
    ErrorLogId    BIGINT         IDENTITY(1,1) NOT NULL,
    ErrorCode     NVARCHAR(100)                    NULL,
    ErrorMessage  NVARCHAR(2000)               NOT NULL,
    StackTrace    NVARCHAR(MAX)                    NULL,
    ProcedureName NVARCHAR(200)                    NULL,
    ErrorLine     INT                              NULL,
    IpAddress     NVARCHAR(45)                     NULL,
    PlayerId      BIGINT                           NULL,
    ErrorDate     DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    IsResolved    BIT                          NOT NULL DEFAULT 0,
    Checksum      BINARY(16)                       NULL,
    CONSTRAINT PK_ErrorLogs         PRIMARY KEY (ErrorLogId),
    CONSTRAINT FK_ErrorLogs_Players FOREIGN KEY (PlayerId)
        REFERENCES Players (PlayerId)
);
GO

CREATE TABLE APILogs (
    APILogId       BIGINT         IDENTITY(1,1) NOT NULL,
    PlayerId       BIGINT                           NULL,
    HttpMethod     NVARCHAR(10)                 NOT NULL,
    Endpoint       NVARCHAR(500)                NOT NULL,
    StatusCode     INT                              NULL,
    ResponseTimeMs INT                              NULL,
    RequestBody    NVARCHAR(MAX)                    NULL,
    ResponseBody   NVARCHAR(MAX)                    NULL,
    IpAddress      NVARCHAR(45)                     NULL,
    UserAgent      NVARCHAR(500)                    NULL,
    RequestDate    DATETIME2                    NOT NULL DEFAULT GETUTCDATE(),
    Checksum       BINARY(16)                       NULL,
    CONSTRAINT PK_APILogs         PRIMARY KEY (APILogId),
    CONSTRAINT FK_APILogs_Players FOREIGN KEY (PlayerId)
        REFERENCES Players (PlayerId)
);
GO

-- ============================================================
-- FIN DEL SCRIPT
-- Total de tablas creadas: 92
-- ============================================================
