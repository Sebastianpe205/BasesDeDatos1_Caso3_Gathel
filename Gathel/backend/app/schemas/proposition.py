"""
Schemas Pydantic para el dominio de proposiciones.
"""
from datetime import datetime

from pydantic import BaseModel, Field

from app.schemas.common import ApiModel


class PropositionCreate(BaseModel):
    TargetPlayerId: int
    Title: str = Field(min_length=1, max_length=200)
    Description: str | None = Field(default=None, max_length=2000)
    EventDate: datetime
    EventGroupId: int | None = Field(
        default=None,
        description=(
            "Si la proposicion es sobre un evento que ya tiene otras "
            "proposiciones (alguien mas ya propuso sobre el), se manda "
            "el EventGroupId existente. Si se omite, se crea un grupo "
            "de evento nuevo con ventana de votacion de 24 horas."
        ),
    )


class PropositionResponse(ApiModel):
    PropositionId: int
    CreatedByPlayerId: int
    TargetPlayerId: int
    EventGroupId: int
    Title: str
    Description: str | None
    EventDate: datetime | None
    PredictionCloseDate: datetime | None
    IsPublic: bool
    RequiresMoneyPrediction: bool
    RequiresPointPrediction: bool
    CreatedAt: datetime


class PropositionCreatedResponse(ApiModel):
    """Respuesta del SP sp_CrearProposicion: solo los IDs generados."""
    PropositionId: int
    EventGroupId: int


class VoteRequest(BaseModel):
    VoteValue: bool


class AcceptanceRequest(BaseModel):
    IsAccepted: bool
    RejectionReason: str | None = Field(default=None, max_length=500)
