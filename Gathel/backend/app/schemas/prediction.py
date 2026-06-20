"""
Schemas Pydantic para el dominio de predicciones.
"""
from pydantic import BaseModel


class PredictionCreate(BaseModel):
    # TODO: definir campos (valor de prediccion, monto en puntos/dinero)
    pass


class PredictionResponse(BaseModel):
    # TODO: definir campos expuestos al frontend
    pass
