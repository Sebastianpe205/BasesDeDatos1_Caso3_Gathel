"""
Schemas Pydantic para el dominio de notificaciones.
"""
from datetime import datetime

from app.schemas.common import ApiModel


class NotificationResponse(ApiModel):
    NotificationId: int
    NotificationTypeId: int
    Title: str
    Message: str
    IsRead: bool
    Priority: int
    CreatedAt: datetime
