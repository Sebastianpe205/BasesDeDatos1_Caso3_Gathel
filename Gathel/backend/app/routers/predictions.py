"""
Endpoints del dominio de predicciones.
"""
from fastapi import APIRouter

router = APIRouter(tags=["predictions"])

# TODO: POST /propositions/{id}/predictions
# TODO: GET  /players/me/predictions
