"""
Modelos ORM de solo lectura para el dominio de predicciones.
Tablas: Predictions, PredictionPointBets, PredictionMoneyBets.
"""
from datetime import datetime
from decimal import Decimal

from sqlalchemy import BigInteger, Boolean, DateTime, ForeignKey, Integer, Numeric
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.models.base import Base


class Prediction(Base):
    __tablename__ = "Predictions"

    PredictionId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PropositionId: Mapped[int] = mapped_column(
        BigInteger, ForeignKey("Propositions.PropositionId")
    )
    PlayerId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Players.PlayerId"))
    PredictionStatusId: Mapped[int] = mapped_column(BigInteger)
    PredictionOutcomeId: Mapped[int | None] = mapped_column(BigInteger, nullable=True)
    PredictionValue: Mapped[bool] = mapped_column(Boolean)
    IsPointPrediction: Mapped[bool] = mapped_column(Boolean, default=False)
    IsMoneyPrediction: Mapped[bool] = mapped_column(Boolean, default=False)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    ClosedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    proposition: Mapped["Proposition"] = relationship("Proposition", lazy="joined")
    point_bet: Mapped["PredictionPointBet"] = relationship(
        "PredictionPointBet", back_populates="prediction", uselist=False
    )
    money_bet: Mapped["PredictionMoneyBet"] = relationship(
        "PredictionMoneyBet", back_populates="prediction", uselist=False
    )


class PredictionPointBet(Base):
    __tablename__ = "PredictionPointBets"

    PointBetId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PredictionId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Predictions.PredictionId"))
    PointsAmount: Mapped[int] = mapped_column(Integer)
    PointsWon: Mapped[int | None] = mapped_column(Integer, nullable=True)
    PlatformCommissionPoints: Mapped[int | None] = mapped_column(Integer, nullable=True)
    CreatorCommissionPoints: Mapped[int | None] = mapped_column(Integer, nullable=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)

    prediction: Mapped["Prediction"] = relationship("Prediction", back_populates="point_bet")


class PredictionMoneyBet(Base):
    __tablename__ = "PredictionMoneyBets"

    MoneyBetId: Mapped[int] = mapped_column(BigInteger, primary_key=True)
    PredictionId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Predictions.PredictionId"))
    CurrencyId: Mapped[int] = mapped_column(BigInteger, ForeignKey("Currencies.CurrencyId"))
    MoneyAmount: Mapped[Decimal] = mapped_column(Numeric(18, 2))
    MoneyWon: Mapped[Decimal | None] = mapped_column(Numeric(18, 2), nullable=True)
    PlatformCommissionMoney: Mapped[Decimal | None] = mapped_column(Numeric(18, 2), nullable=True)
    CreatorCommissionMoney: Mapped[Decimal | None] = mapped_column(Numeric(18, 2), nullable=True)
    CreatedAt: Mapped[datetime] = mapped_column(DateTime)
    UpdatedAt: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)

    prediction: Mapped["Prediction"] = relationship("Prediction", back_populates="money_bet")
    currency: Mapped["Currency"] = relationship("Currency", lazy="joined")


from app.models.catalog import Currency  # noqa: E402,F401
from app.models.proposition import Proposition  # noqa: E402,F401
