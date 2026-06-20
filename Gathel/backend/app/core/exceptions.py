"""
Excepciones de dominio personalizadas para Gathel.
Se capturan en un exception handler global en app/main.py
y se traducen a respuestas HTTP con codigo y mensaje apropiados.
"""


class GathelException(Exception):
    """Excepcion base de dominio para Gathel."""
    pass


class PlayerNotFoundError(GathelException):
    pass


class InsufficientBalanceError(GathelException):
    pass


class PropositionClosedError(GathelException):
    pass


class InvalidCredentialsError(GathelException):
    pass


# TODO: agregar mas excepciones de dominio segun se necesiten
# (ej: PredictionAlreadyExistsError, VotingWindowExpiredError, etc.)
