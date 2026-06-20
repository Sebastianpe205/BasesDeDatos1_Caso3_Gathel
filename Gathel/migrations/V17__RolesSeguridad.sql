/*
=================================================
V17 - Roles y Permisos de Seguridad
=================================================
*/

-------------------------------------------------
-- CREACIÓN DE ROLES
-------------------------------------------------

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_principals
    WHERE name = 'SecurityAdmin'
)
BEGIN
    CREATE ROLE SecurityAdmin;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_principals
    WHERE name = 'SecurityPlayer'
)
BEGIN
    CREATE ROLE SecurityPlayer;
END;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.database_principals
    WHERE name = 'SecurityAuditor'
)
BEGIN
    CREATE ROLE SecurityAuditor;
END;
GO

-------------------------------------------------
-- PERMISOS ADMINISTRADOR
-------------------------------------------------

GRANT SELECT, INSERT, UPDATE, DELETE
ON dbo.Players
TO SecurityAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON dbo.Propositions
TO SecurityAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON dbo.Predictions
TO SecurityAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON dbo.Wallets
TO SecurityAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE
ON dbo.GameEvents
TO SecurityAdmin;

-------------------------------------------------
-- PERMISOS JUGADOR
-------------------------------------------------

GRANT SELECT
ON dbo.Players
TO SecurityPlayer;

GRANT SELECT
ON dbo.Propositions
TO SecurityPlayer;

GRANT SELECT
ON dbo.Predictions
TO SecurityPlayer;

GRANT SELECT
ON dbo.Wallets
TO SecurityPlayer;

-------------------------------------------------
-- PERMISOS AUDITOR
-------------------------------------------------

GRANT SELECT
ON dbo.AuditLogs
TO SecurityAuditor;

GRANT SELECT
ON dbo.SystemLogs
TO SecurityAuditor;

GRANT SELECT
ON dbo.ErrorLogs
TO SecurityAuditor;