"""
Logica de negocio del dominio de notificaciones.
"""
from sqlalchemy.orm import Session

from app.db.stored_procedures import execute_sp_one
from app.models.notification import Notification
from app.schemas.notification import NotificationResponse


def list_notifications(
    player_id: int, db: Session, only_unread: bool = False
) -> list[NotificationResponse]:
    """Lectura via ORM de las notificaciones de un jugador."""
    query = db.query(Notification).filter(Notification.PlayerId == player_id)
    if only_unread:
        query = query.filter(Notification.IsRead.is_(False))

    notifications = query.order_by(Notification.CreatedAt.desc()).all()
    return [NotificationResponse.model_validate(n) for n in notifications]


def mark_as_read(notification_id: int, player_id: int, db: Session) -> None:
    """
    Marca una notificacion como leida.

    Llama a sp_MarcarNotificacionLeida (SP que tu companero debe crear).
    Se manda @PlayerId tambien para que el SP valide que la notificacion
    le pertenece al jugador que hace la peticion (evitar que alguien
    marque notificaciones de otro jugador).

    Contrato esperado del SP:
        EXEC sp_MarcarNotificacionLeida
            @NotificationId = ?, @PlayerId = ?
    """
    execute_sp_one(
        "sp_MarcarNotificacionLeida",
        {"NotificationId": notification_id, "PlayerId": player_id},
    )