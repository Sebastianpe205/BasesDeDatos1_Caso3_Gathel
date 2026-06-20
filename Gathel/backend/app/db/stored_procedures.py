"""
Helper generico para invocar Stored Procedures de SQL Server.

IMPORTANTE: este archivo NO contiene la definicion de los SPs.
La definicion (CREATE PROCEDURE ...) vive en los archivos .sql de
las migraciones de Flyway, en Gathel/migrations (responsabilidad
del companero). Aqui solo se centraliza la logica de Python para
LLAMARLOS desde los services/.

Convencion asumida para los SPs del MVP:
- Cada SP maneja su propia transaccion internamente
  (BEGIN TRANSACTION / COMMIT / ROLLBACK con TRY/CATCH dentro del SP).
- Cada SP devuelve su resultado mediante un SELECT final, en vez de
  parametros OUTPUT, para simplificar el consumo desde Python.
  Ej: dentro del SP -> 'SELECT @NuevoWalletId AS WalletId, @NuevoBalance AS Balance;'
- Si un SP falla, debe lanzar un THROW/RAISERROR con un mensaje legible;
  ese mensaje se propaga aqui dentro de StoredProcedureError.

Acuerda con tu companero los nombres exactos y los parametros de cada
SP antes de usarlos desde los services -- ver Tareas_Deryan.md / Tareas_Sebas.md
o el documento compartido de firmas de SPs.
"""
import logging
from typing import Any

import pyodbc

from app.core.exceptions import StoredProcedureError
from app.db.connection import get_connection

logger = logging.getLogger("gathel.db.stored_procedures")


def execute_sp(sp_name: str, params: dict[str, Any] | None = None) -> list[dict[str, Any]]:
    """
    Ejecuta un Stored Procedure por nombre con los parametros dados,
    y retorna todas las filas del result set (si el SP termina en SELECT).

    Args:
        sp_name: nombre exacto del SP en SQL Server (ej: 'sp_CrearPrediccion').
        params: diccionario {nombre_parametro: valor}. Los nombres NO
            deben incluir el '@' -- se agrega automaticamente al construir
            el EXEC.

    Returns:
        Lista de diccionarios, uno por cada fila del result set.
        Lista vacia si el SP no devuelve filas.

    Raises:
        StoredProcedureError: si SQL Server reporta un error al ejecutar
            el SP. El mensaje original de SQL Server queda incluido.
    """
    params = params or {}
    placeholders = ", ".join(f"@{name} = ?" for name in params)
    sql = f"EXEC {sp_name} {placeholders}".strip()

    with get_connection() as conn:
        cursor = conn.cursor()
        try:
            cursor.execute(sql, list(params.values()))

            rows: list[dict[str, Any]] = []
            if cursor.description:
                columns = [column[0] for column in cursor.description]
                rows = [dict(zip(columns, row)) for row in cursor.fetchall()]

            conn.commit()
            return rows

        except pyodbc.Error as exc:
            conn.rollback()
            logger.error("Error ejecutando SP '%s': %s", sp_name, exc)
            raise StoredProcedureError(f"Error al ejecutar '{sp_name}': {exc}") from exc
        finally:
            cursor.close()


def execute_sp_one(sp_name: str, params: dict[str, Any] | None = None) -> dict[str, Any] | None:
    """
    Igual que execute_sp, pero retorna unicamente la primera fila
    (o None si el SP no devolvio filas). Util para SPs que retornan
    un solo registro: crear un jugador, consultar un balance, etc.
    """
    rows = execute_sp(sp_name, params)
    return rows[0] if rows else None
