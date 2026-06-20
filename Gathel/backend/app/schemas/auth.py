"""
Schemas Pydantic para autenticacion.
"""
from pydantic import BaseModel, EmailStr

from app.schemas.common import ApiModel


class LoginRequest(BaseModel):
    Email: EmailStr
    Password: str


class TokenResponse(ApiModel):
    AccessToken: str
    RefreshToken: str
    TokenType: str = "bearer"


class RefreshRequest(BaseModel):
    RefreshToken: str
