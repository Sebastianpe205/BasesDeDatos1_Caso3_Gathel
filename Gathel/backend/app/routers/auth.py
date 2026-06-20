"""
Endpoints de autenticacion.
"""
from fastapi import APIRouter

router = APIRouter(prefix="/auth", tags=["auth"])

# TODO: POST /auth/login
# TODO: POST /auth/refresh
