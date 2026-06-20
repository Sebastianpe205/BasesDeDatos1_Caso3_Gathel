"""
Modelos ORM de solo lectura para el dominio de wallets.
Tablas: Wallets, WalletTransactions, WalletTypes.
"""
from datetime import datetime
from decimal import Decimal

from sqlalchemy import BigInteger, Boolean, DateTime, ForeignKey, Numeric, String
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base


class WalletType(Base):
    __tablename__ = "WalletTypes"

    WalletTypeId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    WalletTypeName: Mapped[str] = mapped_column(String(30))
    Description: Mapped[str | None] = mapped_column(String(255), nullable=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)


class Wallet(Base):
    __tablename__ = "Wallets"

    WalletId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    WalletTypeId: Mapped[int] = mapped_column(BigInteger, ForeignKey("WalletTypes.WalletTypeId"))
    CurrencyId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Currencies.CurrencyId"))
    CurrentBalance: Mapped[Decimal] = mapped_column(Numeric(19, 4))
    IsBlocked: Mapped[bool] = mapped_column(Boolean, default=False)
    IsActive: Mapped[bool] = mapped_column(Boolean, default=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    wallet_type: Mapped["WalletType"] = relationship("WalletType", lazy="joined")
    currency: Mapped["Currency"] = relationship("Currency", lazy="joined")
    player: Mapped["Player"] = relationship("Player")


class WalletTransaction(Base):
    __tablename__ = "WalletTransactions"

    WalletTransactionId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    WalletId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Wallets.WalletId"))
    WalletTransactionTypeId: Mapped[int] = mapped_column(BigInteger)
    WalletBalanceFormatId: Mapped[int] = mapped_column(BigInteger)
    Amount: Mapped[Decimal] = mapped_column(Numeric(19, 4))
    PreviousBalance: Mapped[Decimal] = mapped_column(Numeric(19, 4))
    NewBalance: Mapped[Decimal] = mapped_column(Numeric(19, 4))
    Reference: Mapped[str | None] = mapped_column(String(100), nullable=True)
    ObjectSource: Mapped[str | None] = mapped_column(String(50), nullable=True)
    ReferenceId: Mapped[int | None] = mapped_column(BigInteger, nullable=True)
    Description: Mapped[str | None] = mapped_column(String(500), nullable=True)
    TransactionDate: Mapped[datetime] = mapped_column(DateTime)
    CreatedByPlayerId: Mapped[int | None] = mapped_column(
        BigInteger, ForeignKey("Players.PlayerId"), nullable=True
    )

    wallet: Mapped["Wallet"] = relationship("Wallet")


# Imports al final (side-effect: registran las clases en el registry de
# SQLAlchemy) para que las relationship() de arriba, definidas via string,
# se resuelvan sin depender del orden de import en otros archivos.
from app.models.catalog import Currency  # noqa: E402,F401
from app.models.player import Player  # noqa: E402,F401
