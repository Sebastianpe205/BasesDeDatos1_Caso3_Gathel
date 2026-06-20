"""
Schemas Pydantic para el dominio de jugadores.
"""
from pydantic import BaseModel


class PlayerCreate(BaseModel):
    # TODO: definir campos de registro (username, email, password, etc.)
    pass


class PlayerResponse(BaseModel):
    # TODO: definir campos expuestos al frontend (sin datos sensibles)
    pass


class PlayerSettingsUpdate(BaseModel):
    # TODO: definir campos editables de configuracion
    pass
