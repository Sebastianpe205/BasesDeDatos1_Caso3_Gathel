--Vista 1 - Balances de jugadores
CREATE OR ALTER VIEW vw_BalancesJugadores
AS
SELECT
    p.PlayerId,
    p.Username,
    p.DisplayName,
    wt.WalletTypeName,
    w.CurrentBalance
FROM Players p
    INNER JOIN Wallets w
        ON w.PlayerId = p.PlayerId
    INNER JOIN WalletTypes wt
        ON wt.WalletTypeId = w.WalletTypeId;
GO
--Vista 2 - Proposiciones activas
CREATE OR ALTER VIEW vw_ProposicionesActivas
AS
SELECT
    pr.PropositionId,
    pr.Title,
    pr.Description,
    pr.EventDate,
    pr.PredictionCloseDate,

    creador.Username AS Creador,
    objetivo.Username AS Objetivo,

    ps.StatusName
FROM Propositions pr
    INNER JOIN Players creador
        ON creador.PlayerId = pr.CreatedByPlayerId
    INNER JOIN Players objetivo
        ON objetivo.PlayerId = pr.TargetPlayerId
    INNER JOIN PropositionStatuses ps
        ON ps.StatusId = pr.StatusId
WHERE pr.StatusId = 4;
GO
--Vista 3 - Predicciones por jugador
CREATE OR ALTER VIEW vw_PrediccionesJugador
AS
SELECT
    p.PlayerId,
    p.Username,

    pred.PredictionId,
    pred.PropositionId,

    po.PredictionOutcomeName,
    ps.PredictionStatusName,

    pred.CreatedAt
FROM Predictions pred
    INNER JOIN Players p
        ON p.PlayerId = pred.PlayerId
    INNER JOIN PredictionOutcomes po
        ON po.PredictionOutcomeId = pred.PredictionOutcomeId
    INNER JOIN PredictionStatuses ps
        ON ps.PredictionStatusId = pred.PredictionStatusId;
GO
--Vista 4 - Resultados de proposiciones
CREATE OR ALTER VIEW vw_ResultadosProposiciones
AS
SELECT
    pr.PropositionId,
    pr.Title,

    COUNT(pred.PredictionId) AS TotalPredicciones,

    SUM(
        CASE
            WHEN pred.PredictionValue = 1
            THEN 1
            ELSE 0
        END
    ) AS VotosSi,

    SUM(
        CASE
            WHEN pred.PredictionValue = 0
            THEN 1
            ELSE 0
        END
    ) AS VotosNo
FROM Propositions pr
    LEFT JOIN Predictions pred
        ON pred.PropositionId = pr.PropositionId
GROUP BY
    pr.PropositionId,
    pr.Title;
GO