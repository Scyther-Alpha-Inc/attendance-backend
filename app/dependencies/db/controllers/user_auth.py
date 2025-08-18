from typing import Annotated
from fastapi import Depends
from app.controllers.user_auth import UserAuthController
from app.dependencies.db.db_session_dep import DBSessionDep


def user_auth_controller_dep(db_session: DBSessionDep) -> UserAuthController:
    return UserAuthController(db_session)


UserAuthControllerDep = Annotated[UserAuthController, Depends(user_auth_controller_dep)]
