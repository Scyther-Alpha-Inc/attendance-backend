from typing import List
from app.models.user import User
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import delete, func, select


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

    async def bulk_create(self, users: List[User]):
        try:
            self.session.add_all(users)
            await self.session.commit()
            await self.session.refresh(users)
            return users
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def by_id(self, id: UUID):
        stmt = select(User).filter(User.id == id)
        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()

    async def by_gctu_id(self, gctu_id: str):
        stmt = select(User).where(func.lower(User.gctu_id) == func.lower(gctu_id))
        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()

    async def search(self, query: str, page: int = 1, limit: int = 10):
        """Search users by name, gctu_id, or email (case-insensitive)"""
        offset = (page - 1) * limit
        search_pattern = f"%{query.lower()}%"

        stmt = (
            select(User)
            .where(
                (func.lower(User.name).like(search_pattern))
                | (func.lower(User.gctu_id).like(search_pattern))
                | (func.lower(User.email).like(search_pattern))
            )
            .limit(limit)
            .offset(offset)
        )
        result = await self.session.execute(stmt)
        return result.scalars().all()
