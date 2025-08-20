from typing import Annotated

from fastapi import Depends
from app.controllers.oauth.zoom_oauth_controller import ZoomOauthController
from app.dependencies.db.db_session_dep import DBSessionDep


def zoom_oauth_controller_dep(session: DBSessionDep) -> ZoomOauthController:
    return ZoomOauthController(session)


ZoomOauthControllerDep = Annotated[
    ZoomOauthController, Depends(zoom_oauth_controller_dep)
]
