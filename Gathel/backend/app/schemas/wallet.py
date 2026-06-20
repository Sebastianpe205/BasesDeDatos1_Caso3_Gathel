"""
Schemas Pydantic para el dominio de wallets.
"""
from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, Field

from app.schemas.common import ApiModel


class WalletResponse(ApiModel):
    """
    Respuesta 'plana' que combina datos de Wallets + WalletTypes +
    Currencies. NO se construye con model_validate(wallet_orm) directo
    porque WalletTypeName/CurrencyCode viven en relaciones anidadas
    (wallet.wallet_type.WalletTypeName) -- el service la arma a mano:

        WalletResponse(
            WalletId=w.WalletId,
            WalletTypeName=w.wallet_type.WalletTypeName,
            CurrencyCode=w.currency.CurrencyCode,
            CurrentBalance=w.CurrentBalance,
            IsBlocked=w.IsBlocked,
        )
    """
    WalletId: int
    WalletTypeName: str
    CurrencyCode: str
    CurrentBalance: Decimal
    IsBlocked: bool


class WalletTransactionResponse(ApiModel):
    WalletTransactionId: int
    Amount: Decimal
    PreviousBalance: Decimal
    NewBalance: Decimal
    Description: str | None
    TransactionDate: datetime


class PointPurchaseRequest(BaseModel):
    PointsAmount: int = Field(gt=0)
    PaymentMethodId: int
    CurrencyId: int
    AmountPaid: Decimal = Field(gt=0)
