from fastapi import APIRouter

from .user_routers import user_router

v1_router = APIRouter(prefix="/v1", tags=["v1"])

v1_router.include_router(user_router)