"""
Endpoints del dominio de wallets.
"""
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.security import get_current_player_id
from app.db.session import get_db
from app.schemas.wallet import (
    PointPurchaseRequest,
    WalletResponse,
    WalletTransactionResponse,
)
from app.services import wallet_service

router = APIRouter(prefix="/players/me/wallet", tags=["wallets"])


@router.get("", response_model=list[WalletResponse])
def get_my_wallets(
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> list[WalletResponse]:
    """Balance de todas las wallets (puntos y dinero) del jugador autenticado."""
    return wallet_service.get_balance(player_id, db)


@router.get("/{wallet_id}/transactions", response_model=list[WalletTransactionResponse])
def get_wallet_transactions(
    wallet_id: int,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> list[WalletTransactionResponse]:
    """
    Historial de movimientos de una wallet especifica del jugador
    autenticado. wallet_service valida que la wallet le pertenezca.
    """
    return wallet_service.get_transaction_history(wallet_id, player_id, db)


@router.post("/purchase", response_model=WalletResponse)
def purchase_points(
    data: PointPurchaseRequest,
    player_id: int = Depends(get_current_player_id),
    db: Session = Depends(get_db),
) -> WalletResponse:
    """Compra de puntos para el jugador autenticado."""
    return wallet_service.purchase_points(player_id, data, db)
