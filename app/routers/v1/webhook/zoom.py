from fastapi import APIRouter

from app.controllers.webhook.zoom_webhook_controller import ZoomWebhookController
from app.dependencies.controllers.webhook.zoom import ZoomWebhookControllerDep
from app.schema.zoom_webhook import ZoomWebhookEvent

zoom_webhook_router = APIRouter(prefix="/zoom", tags=["zoom"])


@zoom_webhook_router.post("/")
async def zoom_webhook(webhook_event: ZoomWebhookEvent, zwc: ZoomWebhookControllerDep):
    return await zwc.handle_webhook(webhook_event)
