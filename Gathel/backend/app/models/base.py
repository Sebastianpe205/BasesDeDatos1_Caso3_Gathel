"""
Clase base declarativa de SQLAlchemy, usada por todos los modelos ORM
de lectura de Gathel.
"""
from sqlalchemy.orm import DeclarativeBase


class Base(DeclarativeBase):
    """Clase base para todos los modelos ORM de lectura."""
    pass
