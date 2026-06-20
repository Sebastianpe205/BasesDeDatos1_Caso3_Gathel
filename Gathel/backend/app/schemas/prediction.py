"""
Schemas Pydantic para el dominio de predicciones.

Nota: los nombres de campo aqui son en ingles (consistentes con el
resto de los schemas/modelos), aunque el SP sp_CrearPrediccion usa
parametros en espanol (@EsPuntos, @MontoPuntos, etc.). El mapeo entre
ambos se hace en prediction_service.py al construir el diccionario de
parametros para execute_sp -- un solo punto de traduccion, en vez de
propagar nombres en espanol por todo el codigo Python.
"""
from datetime import datetime
from decimal import Decimal

from pydantic import BaseModel, Field, model_validator

from app.schemas.common import ApiModel


class PredictionCreate(BaseModel):
    PredictionValue: bool
    IsPointPrediction: bool
    IsMoneyPrediction: bool
    PointsAmount: int | None = Field(default=None, gt=0)
    CurrencyId: int | None = None
    MoneyAmount: Decimal | None = Field(default=None, gt=0)

    @model_validator(mode="after")
    def validar_montos(self) -> "PredictionCreate":
        if not self.IsPointPrediction and not self.IsMoneyPrediction:
            raise ValueError("La prediccion debe ser en puntos, en dinero, o ambos.")
        if self.IsPointPrediction and self.PointsAmount is None:
            raise ValueError("PointsAmount es requerido cuando IsPointPrediction es true.")
        if self.IsMoneyPrediction and (self.CurrencyId is None or self.MoneyAmount is None):
            raise ValueError(
                "CurrencyId y MoneyAmount son requeridos cuando IsMoneyPrediction es true."
            )
        return self


class PredictionResponse(ApiModel):
    PredictionId: int
    PropositionId: int
    PredictionValue: bool
    IsPointPrediction: bool
    IsMoneyPrediction: bool
    CreatedAt: datetime


class PredictionCreatedResponse(ApiModel):
    """Respuesta del SP sp_CrearPrediccion: solo el ID generado."""
    PredictionId: int
