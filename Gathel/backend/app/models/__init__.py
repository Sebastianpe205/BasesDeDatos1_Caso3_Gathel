"""
Paquete app.models: modelos ORM de solo lectura.

Se importan todas las clases aqui para garantizar que SQLAlchemy
registre todas las relaciones correctamente, sin importar el orden
en que cada servicio las importe por primera vez.
"""
from app.models.catalog import Country, Currency, Gender, Language
from app.models.notification import Notification, NotificationType
from app.models.player import (
    AuthenticationCredentials,
    Player,
    PlayerProfile,
    PlayerSettings,
)
from app.models.prediction import Prediction, PredictionMoneyBet, PredictionPointBet
from app.models.proposition import (
    Proposition,
    PropositionGroup,
    PropositionResult,
    PropositionStatus,
)
from app.models.wallet import Wallet, WalletTransaction, WalletType

__all__ = [
    "Country", "Currency", "Gender", "Language",
    "Notification", "NotificationType",
    "AuthenticationCredentials", "Player", "PlayerProfile", "PlayerSettings",
    "Prediction", "PredictionMoneyBet", "PredictionPointBet",
    "Proposition", "PropositionGroup", "PropositionResult", "PropositionStatus",
    "Wallet", "WalletTransaction", "WalletType",
]
