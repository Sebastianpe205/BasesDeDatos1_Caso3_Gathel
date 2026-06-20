"""
Endpoints del dominio de notificaciones.
"""
from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session

from app.core.security import get_current_player_id
from app.db.session import get_db
from app.schemas.notification import NotificationResponse
from app.services import notification_service

router = APIRouter(prefix="/players/me/notifications", tags=["notifications"])


@router.get("", response_model=list[NotificationResponse])
def list_my_notifications(
    only_unread: bool = Query(default=False),
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> list[NotificationResponse]:
    """Lista las notificaciones del jugador autenticado."""
    return notification_service.list_notifications(player_id, db, only_unread=only_unread)


@router.put("/{notification_id}/read", status_code=204)
def mark_notification_as_read(
    notification_id: int,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> None:
    """Marca una notificacion del jugador autenticado como leida."""
    notification_service.mark_as_read(notification_id, player_id, db)
