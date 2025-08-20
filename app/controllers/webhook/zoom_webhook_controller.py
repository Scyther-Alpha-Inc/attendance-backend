
from sqlalchemy.ext.asyncio import AsyncSession

from app.schema.zoom_webhook import ZoomWebhookEvent


class ZoomWebhookController:
    def __init__(self,session:AsyncSession) -> None:
        self.session = session


    async def handle_webhook(self, webhook_event: ZoomWebhookEvent) -> None:
        print(webhook_event)