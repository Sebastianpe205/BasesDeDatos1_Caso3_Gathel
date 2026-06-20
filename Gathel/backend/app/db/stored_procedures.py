"""
Helper generico para invocar Stored Procedures de SQL Server.

IMPORTANTE: este archivo NO contiene la definicion de los SPs.
La definicion (CREATE PROCEDURE ...) vive en los archivos .sql de
las migraciones de Flyway, en database/migrations a nivel raiz del
repositorio (responsabilidad del companero). Aqui solo se centraliza
la logica de Python para LLAMARLOS desde los services/.
"""
# from app.db.connection import get_connection
# from app.core.exceptions import GathelException


def execute_sp(sp_name: str, params: dict | None = None):
    """
    Ejecuta un Stored Procedure por nombre con los parametros dados.

    Args:
        sp_name: nombre exacto del SP en SQL Server (ej: 'sp_CrearPrediccion').
        params: diccionario de parametros a pasar al SP.

    Returns:
        Resultado del SP (filas y/o valor de retorno).
    """
    # TODO: implementar construccion dinamica del EXEC con parametros
    # TODO: manejar errores de SQL Server y traducirlos a excepciones de dominio
    raise NotImplementedError
