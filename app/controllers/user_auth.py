from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.user_repo import UserRepo
from ..models.user import User


class UserAuthController:
    def __init__(self, session: AsyncSession):
        self.__user_repo = UserRepo(session)

    async def register(self, user: User):
        return await self.__user_repo.create(user)

    async def populate_user(self, users: list[User]):
        for user in users:
            await self.__user_repo.create(user)
        await self.__user_repo.session.commit()
        return users