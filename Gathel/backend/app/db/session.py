"""
Engine y sesiones de SQLAlchemy para las operaciones de LECTURA (ORM).

Las escrituras NO pasan por aqui: siempre van a traves de Stored
Procedures (ver stored_procedures.py). Los SPs en si se definen en
los archivos .sql de las migraciones de Flyway (carpeta
Gathel/migrations), responsabilidad del companero -- NO en este
proyecto de backend.
"""
from collections.abc import Generator

from sqlalchemy import create_engine
from sqlalchemy.orm import Session, sessionmaker

from app.core.config import settings

engine = create_engine(
    settings.sqlalchemy_database_uri,
    pool_pre_ping=True,    # valida la conexion antes de usarla (evita conexiones muertas)
    pool_size=10,
    max_overflow=5,
    fast_executemany=True,  # mejora el rendimiento de pyodbc con SQL Server
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_db() -> Generator[Session, None, None]:
    """
    Dependency de FastAPI que provee una sesion de base de datos
    para un solo request, y la cierra automaticamente al terminar.

    Uso en un router:
        @router.get("/players/me")
        def get_me(db: Session = Depends(get_db)):
            ...
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
