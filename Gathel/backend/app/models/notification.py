"""
Modelos ORM de solo lectura para el dominio de notificaciones.
Tablas: Notifications, NotificationTypes.
"""
from datetime import datetime

from sqlalchemy import BigInteger, Boolean, DateTime, ForeignKey, SmallInteger, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base


class NotificationType(Base):
    __tablename__ = "NotificationTypes"

    NotificationTypeId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    NotificationTypeName: Mapped[str] = mapped_column(String(100))
    Description: Mapped[str | None] = mapped_column(String(500), nullable=True)
    AllowsEmail: Mapped[bool] = mapped_column(Boolean, default=False)
    AllowsPush: Mapped[bool] = mapped_column(Boolean, default=False)
    AllowsSMS: Mapped[bool] = mapped_column(Boolean, default=False)
    IsActive: Mapped[bool] = mapped_column(Boolean, default=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)


class Notification(Base):
    __tablename__ = "Notifications"

    NotificationId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    NotificationTypeId: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("NotificationTypes.NotificationTypeId")
    )
    Title: Mapped[str] = mapped_column(String(200))
    Message: Mapped[str] = mapped_column(String(1000))
    IsRead: Mapped[bool] = mapped_column(Boolean, default=False)
    Priority: Mapped[int] = mapped_column(SmallInteger, default=3)
    ReadAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)

    notification_type: Mapped["NotificationType"] = relationship(
        "NotificationType", lazy="joined"
    )
