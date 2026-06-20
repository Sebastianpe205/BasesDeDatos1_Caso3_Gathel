/*
=================================================
V19 - Row Level Security (RLS)
=================================================
*/

-------------------------------------------------
-- FUNCIÓN DE FILTRO
-------------------------------------------------

CREATE FUNCTION dbo.fn_PlayerWalletFilter
(
    @PlayerId BIGINT
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
(
    SELECT 1 AS AccessResult
    WHERE @PlayerId =
          CAST(SESSION_CONTEXT(N'PlayerId') AS BIGINT)
);
GO

-------------------------------------------------
-- POLÍTICA DE SEGURIDAD
-------------------------------------------------

CREATE SECURITY POLICY WalletSecurityPolicy
ADD FILTER PREDICATE
dbo.fn_PlayerWalletFilter(PlayerId)
ON dbo.Wallets
WITH (STATE = ON);
GO