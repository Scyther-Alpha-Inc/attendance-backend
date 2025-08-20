from uuid import UUID
from fastapi import APIRouter, Query

from app.dependencies.controllers.oauth.zoom_oauth_controller_dep import (
    ZoomOauthControllerDep,
)

zoom_oauth_router = APIRouter(prefix="/zoom", tags=["zoom"])


@zoom_oauth_router.get("/redirect")
async def zoom_oauth(code: str, state: UUID, zoc: ZoomOauthControllerDep):
    return await zoc.handle_oauth_callback(code, state)
