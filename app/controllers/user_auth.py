from http import HTTPStatus
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.user_repo import UserRepo
from app.schema.user_auth import UserLoginInput
from core.env_settings import EnvironmentSettings
from core.exceptions.simple_exception import SimpleException
from core.security.jwt_handler import JWTHandler
from core.security.password_handler import PasswordHandler
from ..models.user import User


class UserAuthController:
    def __init__(self, session: AsyncSession):
        self.__user_repo = UserRepo(session)
        self.__token_handler = JWTHandler(EnvironmentSettings.TOKEN_SECRET)

    async def register(self, user: User):
        user.pin = PasswordHandler.hash(user.pin)
        created_user = await self.__user_repo.create(user)
        token = self.__token_handler.encode(
            {"id": created_user.id},
            EnvironmentSettings.ACCESS_EXPIRES_IN_MIN,
        )
        return {
            "token": token,
            "role": created_user.role,
            "user": created_user.model_dump(exclude={"pin"}),
        }

    async def populate_user(self, users: list[User]):
        for user in users:
            await self.__user_repo.create(user)
        await self.__user_repo.session.commit()
        return users

    async def login(self, login_input: UserLoginInput):
        user = await self.__user_repo.by_gctu_id(login_input.gctu_id)
        if not user:
            raise SimpleException(HTTPStatus.NOT_FOUND, "User not found")
        if not PasswordHandler.verify(login_input.pin, user.pin):
            raise SimpleException(
                HTTPStatus.UNAUTHORIZED, "Invalid credentials"
            )
        token = self.__token_handler.encode(
            {"id": str(user.id)},
            EnvironmentSettings.ACCESS_EXPIRES_IN_MIN,
        )
        
        return {
            "token": token,
            "role": user.role,
            "user": user.model_dump(exclude={"pin"}),
        }
