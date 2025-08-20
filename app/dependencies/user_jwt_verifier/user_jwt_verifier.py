from fastapi import Header
from http import HTTPStatus
from typing import Annotated
from uuid import UUID
from app.repositories.user_repo import UserRepo
from app.dependencies.db.db_session_dep import DBSessionDep
from core.customs.user_request import UserRequest
from core.env_settings import EnvironmentSettings
from core.exceptions.simple_exception import SimpleException
from core.security.jwt_handler import JWTHandler


async def user_jwt_verifier(
    db_session: DBSessionDep,
    authorization: Annotated[str, Header()],
    request: UserRequest,
):
    jwt_handler = JWTHandler(EnvironmentSettings.TOKEN_SECRET)
    user_repo = UserRepo(db_session)
    token =  authorization if "Bearer" in authorization else authorization.split(" ")[-1]
    decoded_token = jwt_handler.decode(token)
    if not "id" in decoded_token:
        raise SimpleException(
            HTTPStatus.UNAUTHORIZED,
            "Invalid token provided ",
        )

    request.user_id = UUID(decoded_token["id"])
    current_user = await user_repo.by_id(UUID(decoded_token["id"]))
    if not current_user:
        raise SimpleException(
            HTTPStatus.UNAUTHORIZED,
            "User not found",
        )
    request.current_user = current_user
    return current_user