"""
Endpoints del dominio de jugadores.
"""
from fastapi import APIRouter

router = APIRouter(prefix="/players", tags=["players"])

# TODO: POST /players              -> registro de jugador
# TODO: GET /players/me            -> perfil propio
# TODO: PUT /players/me/settings   -> actualizar configuracion
