"""
Schemas Pydantic para el dominio de jugadores.
"""
from datetime import datetime

from pydantic import BaseModel, EmailStr, Field

from app.schemas.common import ApiModel


class PlayerCreate(BaseModel):
    Username: str = Field(min_length=3, max_length=30, pattern=r"^[a-zA-Z0-9_]+$")
    Email: EmailStr
    Password: str = Field(min_length=8)
    DisplayName: str = Field(min_length=1, max_length=100)
    CountryId: int | None = None


class PlayerResponse(ApiModel):
    PlayerId: int
    Username: str
    Email: EmailStr
    DisplayName: str
    CountryId: int | None
    IsVerified: bool
    IsActive: bool
    CreatedAt: datetime


class PlayerSettingsUpdate(BaseModel):
    """
    Todos los campos son opcionales para soportar actualizaciones
    parciales (PUT con solo los campos que el usuario quiere cambiar).
    """
    IsProfilePublic: bool | None = None
    AllowTaggedPropositions: bool | None = None
    AllowNotifications: bool | None = None
    AllowEmailNotifications: bool | None = None
    AllowMoneyPredictions: bool | None = None


class PlayerSettingsResponse(ApiModel):
    IsProfilePublic: bool
    AllowTaggedPropositions: bool
    AllowNotifications: bool
    AllowEmailNotifications: bool
    AllowMoneyPredictions: bool
