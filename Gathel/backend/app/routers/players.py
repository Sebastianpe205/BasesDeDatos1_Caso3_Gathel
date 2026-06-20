"""
Endpoints del dominio de jugadores.
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.security import get_current_player_id
from app.db.session import get_db
from app.schemas.player import (
    PlayerCreate,
    PlayerResponse,
    PlayerSettingsResponse,
    PlayerSettingsUpdate,
)
from app.services import player_service

router = APIRouter(prefix="/players", tags=["players"])


@router.post("", response_model=PlayerResponse, status_code=201)
def register_player(data: PlayerCreate, db: Session = Depends(get_db)) -> PlayerResponse:
    """Registra un nuevo jugador. Endpoint publico, sin autenticacion."""
    return player_service.register_player(data, db)


@router.get("/me", response_model=PlayerResponse)
def get_my_profile(
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> PlayerResponse:
    """Perfil del jugador autenticado."""
    return player_service.get_player_profile(player_id, db)


@router.get("/me/settings", response_model=PlayerSettingsResponse)
def get_my_settings(
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> PlayerSettingsResponse:
    """Configuracion del jugador autenticado."""
    return player_service.get_player_settings(player_id, db)


@router.put("/me/settings", response_model=PlayerSettingsResponse)
def update_my_settings(
    data: PlayerSettingsUpdate,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> PlayerSettingsResponse:
    """Actualiza (parcialmente) la configuracion del jugador autenticado."""
    return player_service.update_settings(player_id, data, db)
