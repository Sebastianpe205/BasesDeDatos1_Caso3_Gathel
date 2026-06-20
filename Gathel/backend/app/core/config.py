"""
Configuracion de la aplicacion, leida desde variables de entorno.
Esta clase centraliza todas las variables necesarias para conectar
con SQL Server y para la generacion/validacion de JWT.
"""
from functools import lru_cache
from urllib.parse import quote_plus

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    # --- Base de datos (SQL Server) ---
    DB_SERVER: str
    DB_PORT: int = 1433
    DB_NAME: str
    DB_USER: str
    DB_PASSWORD: str
    DB_DRIVER: str = "ODBC Driver 18 for SQL Server"
    DB_ENCRYPT: bool = True
    DB_TRUST_SERVER_CERTIFICATE: bool = True

    # --- JWT ---
    JWT_SECRET_KEY: str
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 15
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7

    # --- Aplicacion ---
    APP_NAME: str = "Gathel API"
    ENVIRONMENT: str = "local"  # local | docker | production
    LOG_LEVEL: str = "INFO"

    def _odbc_params(self) -> str:
        """Construye los parametros de conexion ODBC compartidos por ambas cadenas."""
        return (
            f"DRIVER={{{self.DB_DRIVER}}};"
            f"SERVER={self.DB_SERVER},{self.DB_PORT};"
            f"DATABASE={self.DB_NAME};"
            f"UID={self.DB_USER};"
            f"PWD={self.DB_PASSWORD};"
            f"Encrypt={'yes' if self.DB_ENCRYPT else 'no'};"
            f"TrustServerCertificate={'yes' if self.DB_TRUST_SERVER_CERTIFICATE else 'no'};"
        )

    @property
    def sqlalchemy_database_uri(self) -> str:
        """
        Cadena de conexion para SQLAlchemy (driver pyodbc).
        Usada exclusivamente para las operaciones de LECTURA via ORM.
        """
        return f"mssql+pyodbc:///?odbc_connect={quote_plus(self._odbc_params())}"

    @property
    def pyodbc_connection_string(self) -> str:
        """
        Cadena de conexion cruda para pyodbc.
        Usada exclusivamente para ejecutar Stored Procedures (ESCRITURA).
        """
        return self._odbc_params()


@lru_cache
def get_settings() -> Settings:
    """Retorna una instancia cacheada de Settings (se lee el .env una sola vez)."""
    return Settings()


settings = get_settings()
