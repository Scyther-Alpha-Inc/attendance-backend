from fastapi import APIRouter

from .zoom import zoom_oauth_router

oauth_router = APIRouter(prefix="/oauth", tags=["oauth"])

oauth_router.include_router(zoom_oauth_router)