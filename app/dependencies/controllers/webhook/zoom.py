from typing import Annotated
from fastapi import Depends

from app.controllers.webhook.zoom_webhook_controller import ZoomWebhookController
from app.dependencies.db.db_session_dep import DBSessionDep


def zoom_webhook_controller(session: DBSessionDep):
    return ZoomWebhookController(session)


ZoomWebhookControllerDep = Annotated[
    ZoomWebhookController, Depends(zoom_webhook_controller)
]
