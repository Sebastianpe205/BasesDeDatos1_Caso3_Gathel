"""
Manejo de conexion cruda con pyodbc, usada exclusivamente para
ejecutar Stored Procedures (operaciones de ESCRITURA).

Se mantiene separado de session.py (SQLAlchemy) porque llamar SPs
con parametros y result sets es mas directo con pyodbc puro que
a traves del ORM.
"""
from collections.abc import Generator
from contextlib import contextmanager

import pyodbc

from app.core.config import settings


@contextmanager
def get_connection() -> Generator[pyodbc.Connection, None, None]:
    """
    Abre una conexion pyodbc a SQL Server y la cierra automaticamente
    al salir del bloque 'with', incluso si ocurre una excepcion.

    Uso:
        with get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("EXEC sp_Algo @Param = ?", [valor])
            conn.commit()
    """
    conn = pyodbc.connect(settings.pyodbc_connection_string, autocommit=False)
    try:
        yield conn
    finally:
        conn.close()
