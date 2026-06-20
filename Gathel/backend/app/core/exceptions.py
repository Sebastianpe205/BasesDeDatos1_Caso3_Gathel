"""
Excepciones de dominio personalizadas para Gathel.

Estas excepciones NO conocen nada de HTTP -- esa traduccion ocurre en
el exception handler global de app/main.py usando EXCEPTION_STATUS_MAP.
Aqui solo se modela el error de negocio en si.
"""


class GathelException(Exception):
    """Excepcion base de dominio para Gathel."""

    def __init__(self, message: str = "Ocurrio un error inesperado."):
        self.message = message
        super().__init__(message)


class PlayerNotFoundError(GathelException):
    def __init__(self, message: str = "Jugador no encontrado."):
        super().__init__(message)


class InvalidCredentialsError(GathelException):
    def __init__(self, message: str = "Credenciales invalidas."):
        super().__init__(message)


class InsufficientBalanceError(GathelException):
    def __init__(self, message: str = "Saldo insuficiente para realizar la operacion."):
        super().__init__(message)


class PropositionNotFoundError(GathelException):
    def __init__(self, message: str = "Proposicion no encontrada."):
        super().__init__(message)


class PropositionClosedError(GathelException):
    def __init__(self, message: str = "La proposicion ya esta cerrada."):
        super().__init__(message)


class VotingWindowExpiredError(GathelException):
    def __init__(self, message: str = "La ventana de votacion de 24 horas ya expiro."):
        super().__init__(message)


class PredictionAlreadyExistsError(GathelException):
    def __init__(self, message: str = "Ya existe una prediccion para esta proposicion."):
        super().__init__(message)


class DuplicateResourceError(GathelException):
    def __init__(self, message: str = "El recurso ya existe."):
        super().__init__(message)


class StoredProcedureError(GathelException):
    """Error generico al ejecutar un Stored Procedure en SQL Server."""

    def __init__(self, message: str = "Error al ejecutar la operacion en la base de datos."):
        super().__init__(message)


# Mapeo de excepcion -> codigo de estado HTTP.
# Se usa en el exception handler global de app/main.py para traducir
# cada excepcion de dominio a la respuesta HTTP correcta.
EXCEPTION_STATUS_MAP = {
    PlayerNotFoundError: 404,
    PropositionNotFoundError: 404,
    InvalidCredentialsError: 401,
    InsufficientBalanceError: 400,
    PropositionClosedError: 400,
    VotingWindowExpiredError: 400,
    PredictionAlreadyExistsError: 409,
    DuplicateResourceError: 409,
    StoredProcedureError: 500,
    GathelException: 500,
}
