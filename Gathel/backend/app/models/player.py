"""
Modelos ORM de solo lectura para el dominio de jugadores.
Tablas: Players, PlayerProfiles, PlayerSettings, AuthenticationCredentials.

Nota: AuthenticationCredentials se incluye aqui (en vez de tener un
archivo separado) porque es estrictamente 1 a 1 con Players y se usa
principalmente en el flujo de login. Se recomienda que auth_service.py
use este modelo via ORM en vez de llamar sp_Login, para cumplir con la
convencion del proyecto de "ORM para lecturas, SPs para escrituras".
"""
from datetime import date, datetime

from sqlalchemy import BigInteger, Boolean, Date, DateTime, ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base


class Player(Base):
    __tablename__ = "Players"

    PlayerId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    Username: Mapped[str] = mapped_column(String(30))
    Email: Mapped[str] = mapped_column(String(255))
    DisplayName: Mapped[str] = mapped_column(String(100))
    CountryId: Mapped[int | None] = mapped_column(
        BigInteger, ForeignKey("Countries.CountryId"), nullable=True
    )
    IsVerified: Mapped[bool] = mapped_column(Boolean, default=False)
    IsActive: Mapped[bool] = mapped_column(Boolean, default=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    DeletedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    country: Mapped["Country"] = relationship("Country", lazy="joined")
    profile: Mapped["PlayerProfile"] = relationship(
        "PlayerProfile", back_populates="player", uselist=False
    )
    settings: Mapped["PlayerSettings"] = relationship(
        "PlayerSettings", back_populates="player", uselist=False
    )
    credentials: Mapped["AuthenticationCredentials"] = relationship(
        "AuthenticationCredentials", back_populates="player", uselist=False
    )


class PlayerProfile(Base):
    __tablename__ = "PlayerProfiles"

    ProfileId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    Biography: Mapped[str | None] = mapped_column(String(500), nullable=True)
    ProfilePictureUrl: Mapped[str | None] = mapped_column(String(500), nullable=True)
    BirthDate: Mapped[date | None] = mapped_column(Date, nullable=True)
    GenderId: Mapped[int | None] = mapped_column(
        BigInteger, ForeignKey("Genders.GenderId"), nullable=True
    )
    PreferredLanguageId: Mapped[int | None] = mapped_column(
        BigInteger, ForeignKey("Languages.LanguageId"), nullable=True
    )
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    player: Mapped["Player"] = relationship("Player", back_populates="profile")
    gender: Mapped["Gender"] = relationship("Gender", lazy="joined")
    preferred_language: Mapped["Language"] = relationship("Language", lazy="joined")


class PlayerSettings(Base):
    __tablename__ = "PlayerSettings"

    SettingId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    IsProfilePublic: Mapped[bool] = mapped_column(Boolean, default=True)
    AllowTaggedPropositions: Mapped[bool] = mapped_column(Boolean, default=True)
    AllowNotifications: Mapped[bool] = mapped_column(Boolean, default=True)
    AllowEmailNotifications: Mapped[bool] = mapped_column(Boolean, default=True)
    AllowMoneyPredictions: Mapped[bool] = mapped_column(Boolean, default=False)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    player: Mapped["Player"] = relationship("Player", back_populates="settings")


class AuthenticationCredentials(Base):
    __tablename__ = "AuthenticationCredentials"

    CredentialId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    PasswordHash: Mapped[str] = mapped_column(String(500))
    PasswordSalt: Mapped[str] = mapped_column(String(500))
    LastLoginAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    IsTemporaryPassword: Mapped[bool] = mapped_column(Boolean, default=False)
    IsBlocked: Mapped[bool] = mapped_column(Boolean, default=False)
    IsActive: Mapped[bool] = mapped_column(Boolean, default=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    player: Mapped["Player"] = relationship("Player", back_populates="credentials")


# Imports al final para evitar ciclos: estas clases viven en catalog.py
# pero se referencian arriba via relationship() con strings, asi que
# SQLAlchemy las resuelve en tiempo de configuracion, no de import.
from app.models.catalog import Country, Gender, Language  # noqa: E402
