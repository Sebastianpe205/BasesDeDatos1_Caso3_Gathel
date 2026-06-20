"""
Endpoints del dominio de wallets.
"""
from fastapi import APIRouter

router = APIRouter(prefix="/players/me/wallet", tags=["wallets"])

# TODO: GET  /players/me/wallet
# TODO: GET  /players/me/wallet/transactions
# TODO: POST /players/me/wallet/purchase
