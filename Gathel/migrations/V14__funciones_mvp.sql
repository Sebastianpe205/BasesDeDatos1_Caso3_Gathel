--Función 1 - Obtener balance de puntos
CREATE OR ALTER FUNCTION fn_ObtenerBalancePuntos
(
    @PlayerId BIGINT
)
RETURNS DECIMAL(19,4)
AS
BEGIN

    DECLARE @Balance DECIMAL(19,4);

    SELECT
        @Balance = CurrentBalance
    FROM Wallets
    WHERE PlayerId = @PlayerId
      AND WalletTypeId = 1;

    RETURN ISNULL(@Balance,0);

END;
GO
--Función 2 - Obtener balance de dinero
CREATE OR ALTER FUNCTION fn_ObtenerBalanceDinero
(
    @PlayerId BIGINT
)
RETURNS DECIMAL(19,4)
AS
BEGIN

    DECLARE @Balance DECIMAL(19,4);

    SELECT
        @Balance = CurrentBalance
    FROM Wallets
    WHERE PlayerId = @PlayerId
      AND WalletTypeId = 2;

    RETURN ISNULL(@Balance,0);

END;
GO
--Función 3 - Total de predicciones realizadas
CREATE OR ALTER FUNCTION fn_TotalPrediccionesJugador
(
    @PlayerId BIGINT
)
RETURNS INT
AS
BEGIN

    DECLARE @Total INT;

    SELECT
        @Total = COUNT(*)
    FROM Predictions
    WHERE PlayerId = @PlayerId;

    RETURN ISNULL(@Total,0);

END;
GO
--Función 4 - Total de proposiciones creadas
CREATE OR ALTER FUNCTION fn_TotalProposicionesJugador
(
    @PlayerId BIGINT
)
RETURNS INT
AS
BEGIN

    DECLARE @Total INT;

    SELECT
        @Total = COUNT(*)
    FROM Propositions
    WHERE CreatedByPlayerId = @PlayerId;

    RETURN ISNULL(@Total,0);

END;
GO