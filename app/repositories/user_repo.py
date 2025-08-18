from app.models.user import User
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError


class UserRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def get_by_id(self, id: UUID):
        return await self.session.get(User, id)

    async def create(self, user: User):
        try:
            self.session.add(user)
            await self.session.commit()
            await self.session.refresh(user)
            return user
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def update(self, user: User):
        try:
            self.session.add(user)
            await self.session.commit()
            await self.session.refresh(user)
            return user
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e
