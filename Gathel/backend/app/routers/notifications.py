"""
Endpoints del dominio de notificaciones.
"""
from fastapi import APIRouter

router = APIRouter(prefix="/players/me/notifications", tags=["notifications"])

# TODO: GET /players/me/notifications
