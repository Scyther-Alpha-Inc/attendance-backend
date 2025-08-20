from fastapi import APIRouter

from .zoom import zoom_webhook_router

webhook_router = APIRouter(prefix="/webhook", tags=["webhook"])

webhook_router.include_router(zoom_webhook_router)
