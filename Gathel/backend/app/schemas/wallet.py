"""
Schemas Pydantic para el dominio de wallets.
"""
from pydantic import BaseModel


class WalletResponse(BaseModel):
    # TODO: definir campos (balance, tipo de wallet, moneda)
    pass


class WalletTransactionResponse(BaseModel):
    # TODO: definir campos del historial de transacciones
    pass


class PointPurchaseRequest(BaseModel):
    # TODO: definir campos (cantidad de puntos, metodo de pago)
    pass
