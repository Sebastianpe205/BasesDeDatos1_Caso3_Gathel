"""
Logica de negocio del dominio de predicciones.
"""
from sqlalchemy.orm import Session

from app.db.stored_procedures import execute_sp_one
from app.models.prediction import Prediction
from app.schemas.prediction import (
    PredictionCreate,
    PredictionCreatedResponse,
    PredictionResponse,
)


def create_prediction(
    proposition_id: int, player_id: int, data: PredictionCreate, db: Session
) -> PredictionCreatedResponse:
    """
    Crea una prediccion llamando a sp_CrearPrediccion (ya corregido en V12).

    Nota de mapeo: el schema usa nombres en ingles (IsPointPrediction,
    PointsAmount, MoneyAmount), pero el SP espera parametros en espanol
    (EsPuntos, MontoPuntos, MontoDinero). El mapeo se hace aqui, en un
    solo lugar, en vez de propagar nombres en espanol por todo el codigo.
    """
    result = execute_sp_one(
        "sp_CrearPrediccion",
        {
            "PropositionId": proposition_id,
            "PlayerId": player_id,
            "PredictionValue": data.PredictionValue,
            "EsPuntos": data.IsPointPrediction,
            "EsDinero": data.IsMoneyPrediction,
            "MontoPuntos": data.PointsAmount,
            "CurrencyId": data.CurrencyId,
            "MontoDinero": data.MoneyAmount,
        },
    )
    return PredictionCreatedResponse.model_validate(result)


def list_player_predictions(player_id: int, db: Session) -> list[PredictionResponse]:
    """Lectura via ORM de las predicciones de un jugador."""
    predictions = (
        db.query(Prediction)
        .filter(Prediction.PlayerId == player_id)
        .order_by(Prediction.CreatedAt.desc())
        .all()
    )
    return [PredictionResponse.model_validate(p) for p in predictions]
