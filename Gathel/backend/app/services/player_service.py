"""
Logica de negocio del dominio de jugadores.
"""
from sqlalchemy.orm import Session

from app.core.exceptions import PlayerNotFoundError
from app.core.security import hash_password
from app.db.stored_procedures import execute_sp_one
from app.models.player import Player, PlayerSettings
from app.schemas.player import (
    PlayerCreate,
    PlayerResponse,
    PlayerSettingsResponse,
    PlayerSettingsUpdate,
)


def register_player(data: PlayerCreate, db: Session) -> PlayerResponse:
    """
    Registra un nuevo jugador.

    Llama a sp_RegistrarJugador (SP que tu companero debe crear -- ver
    contrato esperado abajo). El SP es responsable de:
      - validar que Username y Email sean unicos (THROW si no lo son),
      - insertar el Player y su AuthenticationCredentials,
      - insertar un PlayerSettings con los valores default,
      - inicializar su wallet de puntos en 100 (WalletTypeId = 1),
      - inicializar su wallet de dinero en 0 (WalletTypeId = 2),
      - devolver el PlayerId generado en un SELECT final.

    Contrato esperado del SP:
        EXEC sp_RegistrarJugador
            @Username = ?, @Email = ?, @PasswordHash = ?,
            @PasswordSalt = ?, @DisplayName = ?, @CountryId = ?
        -- devuelve: SELECT @PlayerId AS PlayerId;
    """
    password_hash = hash_password(data.Password)

    result = execute_sp_one(
        "sp_RegistrarJugador",
        {
            "Username": data.Username,
            "Email": data.Email,
            "PasswordHash": password_hash,
            "PasswordSalt": "",  # bcrypt incluye el salt dentro del propio hash
            "DisplayName": data.DisplayName,
            "CountryId": data.CountryId,
        },
    )

    player = db.query(Player).filter(Player.PlayerId == result["PlayerId"]).first()
    return PlayerResponse.model_validate(player)


def get_player_profile(player_id: int, db: Session) -> PlayerResponse:
    """Lectura via ORM del perfil basico de un jugador."""
    player = db.query(Player).filter(Player.PlayerId == player_id).first()
    if player is None:
        raise PlayerNotFoundError()
    return PlayerResponse.model_validate(player)


def get_player_settings(player_id: int, db: Session) -> PlayerSettingsResponse:
    """Lectura via ORM de la configuracion de un jugador."""
    settings = (
        db.query(PlayerSettings).filter(PlayerSettings.PlayerId == player_id).first()
    )
    if settings is None:
        raise PlayerNotFoundError("El jugador no tiene configuracion registrada.")
    return PlayerSettingsResponse.model_validate(settings)


def update_settings(
    player_id: int, data: PlayerSettingsUpdate, db: Session
) -> PlayerSettingsResponse:
    """
    Actualiza la configuracion de un jugador (actualizacion parcial:
    solo se modifican los campos distintos de None).

    Llama a sp_ActualizarConfiguracionJugador (SP que tu companero debe
    crear). Se recomienda que el SP use COALESCE(@Parametro, ColumnaActual)
    por cada campo, asi soporta updates parciales sin que el backend
    tenga que enviar todos los campos siempre.

    Contrato esperado del SP:
        EXEC sp_ActualizarConfiguracionJugador
            @PlayerId = ?, @IsProfilePublic = ?, @AllowTaggedPropositions = ?,
            @AllowNotifications = ?, @AllowEmailNotifications = ?,
            @AllowMoneyPredictions = ?
        -- todos los parametros (excepto @PlayerId) aceptan NULL = "no cambiar".
        -- devuelve: SELECT * FROM PlayerSettings WHERE PlayerId = @PlayerId;
    """
    result = execute_sp_one(
        "sp_ActualizarConfiguracionJugador",
        {
            "PlayerId": player_id,
            "IsProfilePublic": data.IsProfilePublic,
            "AllowTaggedPropositions": data.AllowTaggedPropositions,
            "AllowNotifications": data.AllowNotifications,
            "AllowEmailNotifications": data.AllowEmailNotifications,
            "AllowMoneyPredictions": data.AllowMoneyPredictions,
        },
    )
    return PlayerSettingsResponse.model_validate(result)
