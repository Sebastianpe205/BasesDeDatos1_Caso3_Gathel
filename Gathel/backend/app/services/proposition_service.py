"""
Logica de negocio del dominio de proposiciones.
"""
from sqlalchemy.orm import Session

from app.core.exceptions import PropositionNotFoundError
from app.db.stored_procedures import execute_sp_one
from app.models.proposition import Proposition
from app.schemas.proposition import (
    AcceptanceRequest,
    PropositionCreate,
    PropositionCreatedResponse,
    PropositionResponse,
    VoteRequest,
)


def create_proposition(
    created_by_player_id: int, data: PropositionCreate, db: Session
) -> PropositionCreatedResponse:
    """Crea una proposicion llamando a sp_CrearProposicion (ya corregido en V12)."""
    result = execute_sp_one(
        "sp_CrearProposicion",
        {
            "CreatedByPlayerId": created_by_player_id,
            "TargetPlayerId": data.TargetPlayerId,
            "Title": data.Title,
            "Description": data.Description,
            "EventDate": data.EventDate,
            "EventGroupId": data.EventGroupId,
        },
    )
    return PropositionCreatedResponse.model_validate(result)


def get_proposition(proposition_id: int, db: Session) -> PropositionResponse:
    """Lectura via ORM de una proposicion especifica."""
    proposition = (
        db.query(Proposition).filter(Proposition.PropositionId == proposition_id).first()
    )
    if proposition is None:
        raise PropositionNotFoundError()
    return PropositionResponse.model_validate(proposition)


def list_propositions(
    db: Session, target_player_id: int | None = None, only_public: bool = True
) -> list[PropositionResponse]:
    """Lectura via ORM de proposiciones, con filtros opcionales."""
    query = db.query(Proposition)
    if target_player_id is not None:
        query = query.filter(Proposition.TargetPlayerId == target_player_id)
    if only_public:
        query = query.filter(Proposition.IsPublic.is_(True))

    propositions = query.order_by(Proposition.CreatedAt.desc()).all()
    return [PropositionResponse.model_validate(p) for p in propositions]


def vote_proposition(
    proposition_id: int, player_id: int, data: VoteRequest, db: Session
) -> None:
    """
    Registra el voto de un jugador sobre una proposicion dentro de su
    grupo de evento.

    Llama a sp_VotarProposicion (SP que tu companero debe crear). El SP
    debe validar que la ventana de votacion (PropositionGroups.VotingDeadline)
    no haya expirado antes de insertar en PropositionVotes (la restriccion
    UNIQUE en (PropositionId, PlayerId) ya evita votos duplicados a nivel
    de base de datos).

    Contrato esperado del SP:
        EXEC sp_VotarProposicion
            @PropositionId = ?, @PlayerId = ?, @VoteValue = ?
    """
    execute_sp_one(
        "sp_VotarProposicion",
        {
            "PropositionId": proposition_id,
            "PlayerId": player_id,
            "VoteValue": data.VoteValue,
        },
    )


def respond_acceptance(
    proposition_id: int, target_player_id: int, data: AcceptanceRequest, db: Session
) -> None:
    """
    Registra si el jugador objetivo de una proposicion la acepta o
    la rechaza.

    Valida que quien responde sea realmente el TargetPlayerId de la
    proposicion -- sin esto, cualquier jugador autenticado podria
    aceptar/rechazar proposiciones dirigidas a otra persona.

    Llama a sp_ResponderAceptacionProposicion (SP que tu companero debe
    crear).

    Contrato esperado del SP:
        EXEC sp_ResponderAceptacionProposicion
            @PropositionId = ?, @TargetPlayerId = ?, @IsAccepted = ?,
            @RejectionReason = ?
    """
    proposition = (
        db.query(Proposition).filter(Proposition.PropositionId == proposition_id).first()
    )
    if proposition is None:
        raise PropositionNotFoundError()
    if proposition.TargetPlayerId != target_player_id:
        raise PropositionNotFoundError("Esta proposicion no esta dirigida a este jugador.")

    execute_sp_one(
        "sp_ResponderAceptacionProposicion",
        {
            "PropositionId": proposition_id,
            "TargetPlayerId": target_player_id,
            "IsAccepted": data.IsAccepted,
            "RejectionReason": data.RejectionReason,
        },
    )
