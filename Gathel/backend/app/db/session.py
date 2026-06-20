"""
Engine y sesiones de SQLAlchemy para las operaciones de LECTURA (ORM).
Las escrituras NO pasan por aqui: siempre van a traves de Stored
Procedures (ver stored_procedures.py). Los SPs en si se definen en
los archivos .sql de las migraciones de Flyway (carpeta database/migrations
a nivel raiz del repo), NO en este proyecto de backend.
"""
# from sqlalchemy import create_engine
# from sqlalchemy.orm import sessionmaker
# from app.core.config import settings

# TODO: construir cadena de conexion mssql+pyodbc a partir de settings
# engine = create_engine(...)
# SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_db():
    """Dependency de FastAPI que provee una sesion de base de datos."""
    # TODO: implementar yield de sesion con manejo de cierre
    raise NotImplementedError
