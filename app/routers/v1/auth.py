from fastapi import APIRouter

from app.dependencies.db.controllers.user_auth import UserAuthControllerDep
from app.schema.user_auth import UserLoginInput


auth_router = APIRouter(prefix="/auth", tags=["auth"])


@auth_router.post("/login")
async def login(
    user: UserLoginInput,
    user_auth_controller: UserAuthControllerDep,
):
    return await user_auth_controller.login(user)