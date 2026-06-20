"""
Schemas Pydantic para el dominio de proposiciones.
"""
from pydantic import BaseModel


class PropositionCreate(BaseModel):
    # TODO: definir campos de creacion de proposicion
    pass


class PropositionResponse(BaseModel):
    # TODO: definir campos expuestos al frontend
    pass


class VoteRequest(BaseModel):
    # TODO: definir campos (valor del voto)
    pass


class AcceptanceRequest(BaseModel):
    # TODO: definir campos (aceptado/rechazado, motivo de rechazo)
    pass
