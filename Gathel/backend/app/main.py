"""
Punto de entrada de la aplicacion FastAPI - Gathel Backend.
Registra los routers de cada dominio y configura middleware global.
"""
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.core.config import settings
from app.core.exceptions import EXCEPTION_STATUS_MAP, GathelException
from app.core.logging import configure_logging, logger
from app.routers import auth, notifications, players, predictions, propositions, wallets

configure_logging()

app = FastAPI(
    title=settings.APP_NAME,
    description="API REST del backend de Gathel: Gaming the Life",
    version="0.1.0",
)

# TODO: restringir allow_origins al dominio real del frontend antes de la
# entrega final (por ahora "*" para no bloquear el desarrollo local).
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(players.router)
app.include_router(wallets.router)
app.include_router(propositions.router)
app.include_router(predictions.router)
app.include_router(notifications.router)


@app.exception_handler(GathelException)
def handle_gathel_exception(request: Request, exc: GathelException) -> JSONResponse:
    """
    Traduce cualquier excepcion de dominio (ver app/core/exceptions.py)
    a la respuesta HTTP correcta usando EXCEPTION_STATUS_MAP. Captura
    GathelException y TODAS sus subclases (PlayerNotFoundError,
    InsufficientBalanceError, etc.) en un solo lugar.
    """
    status_code = EXCEPTION_STATUS_MAP.get(type(exc), 500)
    logger.warning("GathelException: %s (status=%s)", exc.message, status_code)
    return JSONResponse(status_code=status_code, content={"Error": exc.message})


@app.get("/health")
def health_check():
    """Endpoint de chequeo de salud del servicio."""
    return {"status": "ok"}
