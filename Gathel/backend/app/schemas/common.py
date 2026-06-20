"""
Schemas compartidos entre dominios: clase base, paginacion y errores.

Decision de naming: todos los schemas de este proyecto usan PascalCase
para que los nombres de campo coincidan exactamente con los atributos
de los modelos ORM (ver app/models/). Esto permite construir la mayoria
de las respuestas directamente con Schema.model_validate(objeto_orm),
sin mapear nombres a mano.

IMPORTANTE para el frontend: el JSON que devuelve la API usa PascalCase
(ej. "PlayerId", "CurrentBalance") en vez del camelCase tipico de
JavaScript.

Patron usado para respuestas con datos de tablas relacionadas (JOINs):
en vez de modelar relaciones anidadas en el schema (lo que requeriria
alias para mapear nombres de atributos de relationship en minuscula,
como wallet.wallet_type, a campos PascalCase), los services construyen
esas respuestas "planas" explicitamente con kwargs. Ver wallet.py para
un ejemplo.
"""
from pydantic import BaseModel, ConfigDict


class ApiModel(BaseModel):
    """
    Clase base para schemas de respuesta. Habilita 'from_attributes'
    para poder construir el schema directamente desde un objeto ORM:
    Schema.model_validate(objeto_orm).
    """
    model_config = ConfigDict(from_attributes=True)


class PaginationParams(BaseModel):
    Page: int = 1
    PageSize: int = 20


class ErrorResponse(BaseModel):
    """Formato estandar de error devuelto por el exception handler global."""
    Error: str
    Detail: str | None = None
