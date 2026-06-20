"""
Endpoints de autenticacion.
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.db.session import get_db
from app.schemas.auth import LoginRequest, RefreshRequest, TokenResponse
from app.services import auth_service

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post("/login", response_model=TokenResponse)
def login(data: LoginRequest, db: Session = Depends(get_db)) -> TokenResponse:
    """Valida credenciales y devuelve un access_token + refresh_token."""
    return auth_service.login(data.Email, data.Password, db)


@router.post("/refresh", response_model=TokenResponse)
def refresh(data: RefreshRequest) -> TokenResponse:
    """Genera un nuevo access_token a partir de un refresh_token valido."""
    return auth_service.refresh(data.RefreshToken)
