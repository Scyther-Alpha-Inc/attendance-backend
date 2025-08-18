from fastapi import APIRouter

from .auth import auth_router
from .user_routers import user_router
from .lecturer import lecturer_router

v1_router = APIRouter(prefix="/v1", tags=["v1"])

v1_router.include_router(user_router)

v1_router.include_router(auth_router)

v1_router.include_router(lecturer_router)
