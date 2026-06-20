"""
Configuracion del logger de la aplicacion.
"""
import logging
import sys

from app.core.config import settings


def configure_logging() -> None:
    """
    Configura el logging global de la aplicacion.
    Debe llamarse una sola vez al arrancar la app (ver app/main.py).
    """
    logging.basicConfig(
        level=settings.LOG_LEVEL,
        format="%(asctime)s | %(levelname)-8s | %(name)s | %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
        stream=sys.stdout,
    )
    # Silenciar logs muy verbosos de librerias de terceros
    logging.getLogger("uvicorn.access").setLevel(logging.WARNING)


logger = logging.getLogger("gathel")
