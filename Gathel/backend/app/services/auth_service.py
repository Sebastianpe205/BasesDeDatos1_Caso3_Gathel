"""
Logica de negocio de autenticacion: login y manejo de tokens.

login() usa el ORM (no sp_Login) para cumplir con la convencion del
proyecto de "ORM para lecturas, SPs para escrituras" -- login es una
lectura que valida credenciales, no una escritura.
"""
from sqlalchemy.orm import Session

from app.core.exceptions import InvalidCredentialsError
from app.core.security import (
    create_access_token,
    create_refresh_token,
    decode_token,
    verify_password,
)
from app.models.player import Player
from app.schemas.auth import TokenResponse


def login(email: str, password: str, db: Session) -> TokenResponse:
    """
    Valida las credenciales de un jugador y, si son correctas,
    genera un access_token y un refresh_token.

    Raises:
        InvalidCredentialsError: si el email no existe, el jugador
            esta bloqueado/inactivo, o la contrasena no coincide. Se
            usa el mismo mensaje generico en todos los casos para no
            revelar si el problema fue el email o la contrasena.
    """
    player = db.query(Player).filter(Player.Email == email).first()

    if player is None or player.credentials is None:
        raise InvalidCredentialsError()

    credentials = player.credentials

    if credentials.IsBlocked or not credentials.IsActive or not player.IsActive:
        raise InvalidCredentialsError()

    if not verify_password(password, credentials.PasswordHash):
        raise InvalidCredentialsError()

    # TODO: registrar LastLoginAt y el intento en LoginAttempts. Requiere
    # un SP de escritura (ej. sp_RegistrarLogin) que aun no existe; se
    # omite por ahora para no hacer un UPDATE directo desde el ORM.

    access_token = create_access_token(
        player.PlayerId, extra_claims={"username": player.Username}
    )
    refresh_token = create_refresh_token(player.PlayerId)

    return TokenResponse(AccessToken=access_token, RefreshToken=refresh_token)


def refresh(refresh_token: str) -> TokenResponse:
    """
    Genera un nuevo access_token a partir de un refresh_token valido.
    El refresh_token original se reutiliza (no se rota en esta version).
    """
    payload = decode_token(refresh_token, expected_type="refresh")
    player_id = int(payload["sub"])

    new_access_token = create_access_token(player_id)

    return TokenResponse(AccessToken=new_access_token, RefreshToken=refresh_token)
