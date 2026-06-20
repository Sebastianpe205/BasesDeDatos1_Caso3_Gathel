"""
Schemas Pydantic para autenticacion.
"""
from pydantic import BaseModel


class LoginRequest(BaseModel):
    # TODO: definir campos (username/email, password)
    pass


class TokenResponse(BaseModel):
    # TODO: definir campos (access_token, refresh_token, token_type)
    pass


class RefreshRequest(BaseModel):
    # TODO: definir campos (refresh_token)
    pass
