"""
Modelos ORM de solo lectura para catalogos compartidos.
Tablas: Countries, Languages, Genders, Currencies.
"""
from datetime import datetime

from sqlalchemy import BigInteger, Boolean, DateTime, String
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base


class Country(Base):
    __tablename__ = "Countries"

    CountryId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    CountryName: Mapped[str] = mapped_column(String(100))
    Iso2Code: Mapped[str] = mapped_column(String(2))
    Iso3Code: Mapped[str] = mapped_column(String(3))
    PhoneCode: Mapped[str | None] = mapped_column(String(10), nullable=True)
    TimeZone: Mapped[str | None] = mapped_column(String(100), nullable=True)
    IsActive: Mapped[bool] = mapped_column(Boolean, default=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)


class Language(Base):
    __tablename__ = "Languages"

    LanguageId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    LanguageCode: Mapped[str] = mapped_column(String(10))
    LanguageName: Mapped[str] = mapped_column(String(50))
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)


class Gender(Base):
    __tablename__ = "Genders"

    GenderId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    GenderName: Mapped[str] = mapped_column(String(30))
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)


class Currency(Base):
    __tablename__ = "Currencies"

    CurrencyId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    CurrencyCode: Mapped[str] = mapped_column(String(10))
    CurrencyName: Mapped[str] = mapped_column(String(50))
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
