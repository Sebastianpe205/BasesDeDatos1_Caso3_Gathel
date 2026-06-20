"""
Logica de negocio del dominio de wallets.
"""
from sqlalchemy.orm import Session

from app.core.exceptions import PlayerNotFoundError
from app.db.stored_procedures import execute_sp_one
from app.models.wallet import Wallet, WalletTransaction
from app.schemas.wallet import PointPurchaseRequest, WalletResponse, WalletTransactionResponse


def _to_wallet_response(wallet: Wallet) -> WalletResponse:
    """Helper interno para armar el schema 'plano' a partir del objeto ORM."""
    return WalletResponse(
        WalletId=wallet.WalletId,
        WalletTypeName=wallet.wallet_type.WalletTypeName,
        CurrencyCode=wallet.currency.CurrencyCode,
        CurrentBalance=wallet.CurrentBalance,
        IsBlocked=wallet.IsBlocked,
    )


def get_balance(player_id: int, db: Session) -> list[WalletResponse]:
    """
    Lectura via ORM de todas las wallets de un jugador (normalmente 2:
    una de puntos y una de dinero). Reemplaza a sp_ObtenerBalanceJugador
    para cumplir con la convencion de "ORM para lecturas".
    """
    wallets = db.query(Wallet).filter(Wallet.PlayerId == player_id).all()
    if not wallets:
        raise PlayerNotFoundError("El jugador no tiene wallets registradas.")

    return [_to_wallet_response(w) for w in wallets]


def get_transaction_history(
    wallet_id: int, player_id: int, db: Session
) -> list[WalletTransactionResponse]:
    """
    Lectura via ORM del historial de movimientos de una wallet especifica.

    Valida que la wallet pertenezca al jugador autenticado -- sin esto,
    cualquier jugador podria leer el historial de cualquier wallet solo
    adivinando su WalletId.
    """
    wallet = db.query(Wallet).filter(Wallet.WalletId == wallet_id).first()
    if wallet is None or wallet.PlayerId != player_id:
        raise PlayerNotFoundError("La wallet no existe o no pertenece a este jugador.")

    transactions = (
        db.query(WalletTransaction)
        .filter(WalletTransaction.WalletId == wallet_id)
        .order_by(WalletTransaction.TransactionDate.desc())
        .all()
    )
    return [WalletTransactionResponse.model_validate(t) for t in transactions]


def purchase_points(player_id: int, data: PointPurchaseRequest, db: Session) -> WalletResponse:
    """
    Compra de puntos por parte de un jugador que se quedo sin saldo.

    Llama a sp_ComprarPuntos (SP que tu companero debe crear). El SP es
    responsable de registrar el PointPurchase, el FinancialMovement
    correspondiente, y acreditar los puntos en la wallet de puntos del
    jugador (con su WalletTransaction).

    Contrato esperado del SP:
        EXEC sp_ComprarPuntos
            @PlayerId = ?, @PointsAmount = ?, @PaymentMethodId = ?,
            @CurrencyId = ?, @AmountPaid = ?
        -- devuelve: SELECT WalletId FROM Wallets
        --           WHERE PlayerId = @PlayerId AND WalletTypeId = 1;
    """
    result = execute_sp_one(
        "sp_ComprarPuntos",
        {
            "PlayerId": player_id,
            "PointsAmount": data.PointsAmount,
            "PaymentMethodId": data.PaymentMethodId,
            "CurrencyId": data.CurrencyId,
            "AmountPaid": data.AmountPaid,
        },
    )

    wallet = db.query(Wallet).filter(Wallet.WalletId == result["WalletId"]).first()
    return _to_wallet_response(wallet)
