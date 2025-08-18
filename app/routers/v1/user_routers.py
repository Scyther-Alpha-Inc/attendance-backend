from typing import List
from fastapi import APIRouter

from app.dependencies.db.controllers.user_auth import UserAuthControllerDep
from app.schema.user import UserBulkCreateInput, UserCreateInput
from core.customs.user_request import UserRequest
from ...repositories.user_repo import UserRepo
from ...dependencies.db.db_session_dep import DBSessionDep


user_router = APIRouter(prefix="/users", tags=["users"])


@user_router.post("/bulk-create")
async def bulk_create_users(
    users: List[UserCreateInput],
    request: UserRequest,
    user_auth_controller: UserAuthControllerDep,
):
    return await user_auth_controller.populate_user(users)
