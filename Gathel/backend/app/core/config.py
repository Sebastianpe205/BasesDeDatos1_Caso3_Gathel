"""
Configuracion de la aplicacion, leida desde variables de entorno.
"""
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # TODO: definir todos los campos de configuracion necesarios
    # DB_SERVER: str
    # DB_NAME: str
    # DB_USER: str
    # DB_PASSWORD: str
    # JWT_SECRET_KEY: str
    # JWT_ALGORITHM: str = "HS256"
    # ACCESS_TOKEN_EXPIRE_MINUTES: int = 15
    # REFRESH_TOKEN_EXPIRE_DAYS: int = 7

    class Config:
        env_file = ".env"


settings = Settings()
