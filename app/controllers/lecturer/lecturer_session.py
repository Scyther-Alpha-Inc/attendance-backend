from pydantic import UUID4
from app.controllers.user_auth import UserAuthController
from app.models.session import Session
from app.repositories.session_repo import SessionRepo
from app.schema.session import SessionInput
from sqlalchemy.ext.asyncio import AsyncSession


class LecturerSessionController:
    def __init__(self, session: AsyncSession):
        self.__session_repo = SessionRepo(session)
        self.__user_auth_controller = UserAuthController(session)

    async def create_session(self, session_input: SessionInput):
        session = Session(**session_input.model_dump())

        return await self.__session_repo.create(session)

    async def get_session(self, id: UUID4):
        return await self.__session_repo.get_by_id(id)

