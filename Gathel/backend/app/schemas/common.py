"""
Schemas compartidos entre dominios: paginacion y formato de error.
"""
from pydantic import BaseModel


class PaginationParams(BaseModel):
    # TODO: definir campos (page, page_size)
    pass


class ErrorResponse(BaseModel):
    # TODO: definir formato estandar de error (codigo, mensaje, detalles)
    pass
