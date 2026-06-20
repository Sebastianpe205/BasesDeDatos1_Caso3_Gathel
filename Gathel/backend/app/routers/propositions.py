"""
Endpoints del dominio de proposiciones.
"""
from fastapi import APIRouter

router = APIRouter(prefix="/propositions", tags=["propositions"])

# TODO: GET  /propositions
# TODO: GET  /propositions/{id}
# TODO: POST /propositions
# TODO: POST /propositions/{id}/votes
# TODO: POST /propositions/{id}/acceptance
