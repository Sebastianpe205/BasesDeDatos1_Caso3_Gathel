"""
Endpoints del dominio de predicciones.
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.security import get_current_player_id
from app.db.session import get_db
from app.schemas.prediction import (
    PredictionCreate,
    PredictionCreatedResponse,
    PredictionResponse,
)
from app.services import prediction_service

router = APIRouter(tags=["predictions"])


@router.post(
    "/propositions/{proposition_id}/predictions",
    response_model=PredictionCreatedResponse,
    status_code=201,
)
def create_prediction(
    proposition_id: int,
    data: PredictionCreate,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> PredictionCreatedResponse:
    """Crea una prediccion del jugador autenticado sobre una proposicion."""
    return prediction_service.create_prediction(proposition_id, player_id, data, db)


@router.get("/players/me/predictions", response_model=list[PredictionResponse])
def list_my_predictions(
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> list[PredictionResponse]:
    """Lista las predicciones del jugador autenticado."""
    return prediction_service.list_player_predictions(player_id, db)
