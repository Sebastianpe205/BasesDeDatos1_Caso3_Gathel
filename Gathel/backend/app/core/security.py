"""
Utilidades de seguridad: hashing de contrasenas y manejo de JWT.

Notas de diseno:
- El hashing de contrasenas usa bcrypt via passlib. El hash resultante
  es el que se guarda en AuthenticationCredentials.PasswordHash (el
  salt va incluido dentro del propio hash de bcrypt).
- Los tokens JWT llevan el PlayerId en el claim "sub" y un claim "type"
  para distinguir access_token de refresh_token.
"""
from datetime import datetime, timedelta, timezone
from typing import Any

import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from passlib.context import CryptContext

from app.core.config import settings
from app.core.exceptions import InvalidCredentialsError

# Se usa HTTPBearer (no OAuth2PasswordBearer) porque /auth/login recibe
# JSON (LoginRequest), no el formulario username/password que espera el
# flujo OAuth2 password estandar. HTTPBearer solo le dice a Swagger UI
# que muestre el boton "Authorize" para pegar un Bearer token.
_bearer_scheme = HTTPBearer()

_pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def hash_password(password: str) -> str:
    """Genera el hash de una contrasena en texto plano."""
    return _pwd_context.hash(password)


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verifica que una contrasena en texto plano coincida con su hash."""
    return _pwd_context.verify(plain_password, hashed_password)


def _create_token(data: dict[str, Any], expires_delta: timedelta, token_type: str) -> str:
    """Funcion interna compartida para crear access_token y refresh_token."""
    to_encode = data.copy()
    now = datetime.now(timezone.utc)
    to_encode.update({
        "exp": now + expires_delta,
        "iat": now,
        "type": token_type,
    })
    return jwt.encode(to_encode, settings.JWT_SECRET_KEY, algorithm=settings.JWT_ALGORITHM)


def create_access_token(player_id: int, extra_claims: dict[str, Any] | None = None) -> str:
    """
    Crea un access_token de corta duracion para un jugador.

    Args:
        player_id: identificador del jugador autenticado.
        extra_claims: claims adicionales a incluir (ej: roles, username).
    """
    data: dict[str, Any] = {"sub": str(player_id)}
    if extra_claims:
        data.update(extra_claims)
    expires_delta = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    return _create_token(data, expires_delta, token_type="access")


def create_refresh_token(player_id: int) -> str:
    """Crea un refresh_token de larga duracion para un jugador."""
    data = {"sub": str(player_id)}
    expires_delta = timedelta(days=settings.REFRESH_TOKEN_EXPIRE_DAYS)
    return _create_token(data, expires_delta, token_type="refresh")


def decode_token(token: str, expected_type: str | None = None) -> dict[str, Any]:
    """
    Decodifica y valida un JWT (access o refresh).

    Args:
        token: el JWT a decodificar.
        expected_type: si se especifica ("access" o "refresh"), valida
            que el token sea de ese tipo y rechaza el contrario (ej: no
            permitir usar un refresh_token como si fuera un access_token).

    Raises:
        InvalidCredentialsError: si el token es invalido, expiro, o no
            coincide con expected_type.
    """
    try:
        payload = jwt.decode(
            token, settings.JWT_SECRET_KEY, algorithms=[settings.JWT_ALGORITHM]
        )
    except jwt.ExpiredSignatureError:
        raise InvalidCredentialsError("El token ha expirado.")
    except jwt.InvalidTokenError:
        raise InvalidCredentialsError("Token invalido.")

    if expected_type and payload.get("type") != expected_type:
        raise InvalidCredentialsError(f"Se esperaba un token de tipo '{expected_type}'.")

    return payload


def get_current_player_id(
    credentials: HTTPAuthorizationCredentials = Depends(_bearer_scheme),
) -> int:
    """
    Dependency de FastAPI que extrae el access_token del header
    'Authorization: Bearer <token>', lo valida, y devuelve el PlayerId
    autenticado. Se usa en todos los endpoints protegidos de app/routers/.

    Uso en un router:
        @router.get("/players/me")
        def get_me(player_id: int = Depends(get_current_player_id)):
            ...

    Raises:
        HTTPException 401: si el token falta, es invalido, o expiro.
    """
    try:
        payload = decode_token(credentials.credentials, expected_type="access")
        return int(payload["sub"])
    except InvalidCredentialsError as exc:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=exc.message,
            headers={"WWW-Authenticate": "Bearer"},
        ) from exc
