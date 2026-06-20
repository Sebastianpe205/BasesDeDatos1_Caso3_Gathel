"""
Endpoints del dominio de proposiciones.
"""
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.core.security import get_current_player_id
from app.db.session import get_db
from app.schemas.proposition import (
    AcceptanceRequest,
    PropositionCreate,
    PropositionCreatedResponse,
    PropositionResponse,
    VoteRequest,
)
from app.services import proposition_service

router = APIRouter(prefix="/propositions", tags=["propositions"])


@router.get("", response_model=list[PropositionResponse])
def list_propositions(
    target_player_id: int | None = Query(default=None),
    db: Session = Depends(get_db),
) -> list[PropositionResponse]:
    """Lista proposiciones publicas, opcionalmente filtradas por jugador objetivo."""
    return proposition_service.list_propositions(db, target_player_id=target_player_id)


@router.get("/{proposition_id}", response_model=PropositionResponse)
def get_proposition(proposition_id: int, db: Session = Depends(get_db)) -> PropositionResponse:
    """Detalle de una proposicion especifica."""
    return proposition_service.get_proposition(proposition_id, db)


@router.post("", response_model=PropositionCreatedResponse, status_code=201)
def create_proposition(
    data: PropositionCreate,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> PropositionCreatedResponse:
    """Crea una nueva proposicion. El jugador autenticado queda como creador."""
    return proposition_service.create_proposition(player_id, data, db)


@router.post("/{proposition_id}/votes", status_code=204)
def vote_proposition(
    proposition_id: int,
    data: VoteRequest,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> None:
    """Registra el voto del jugador autenticado sobre una proposicion."""
    proposition_service.vote_proposition(proposition_id, player_id, data, db)


@router.post("/{proposition_id}/acceptance", status_code=204)
def respond_acceptance(
    proposition_id: int,
    data: AcceptanceRequest,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> None:
    """
    El jugador objetivo de la proposicion la acepta o la rechaza.
    proposition_service valida que quien responde sea realmente el
    TargetPlayerId de esa proposicion.
    """
    proposition_service.respond_acceptance(proposition_id, player_id, data, db)
