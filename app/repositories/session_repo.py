from uuid import UUID
from app.models.session import Session
from sqlalchemy.ext.asyncio import AsyncSession
from sqlmodel import select


class SessionRepo:
    def __init__(self, session: AsyncSession):
        self.__session = session

    async def create(self, session: Session):
        try:
            self.__session.add(session)
            await self.__session.commit()
            return session
        except Exception as e:
            raise e

    async def get_by_id(self, id: UUID):
        session = await self.__session.get(Session, id)
        if not session:
            return None
        return session

    async def get_by_course_id(self, course_id: UUID, page: int = 1, limit: int = 10):
        offset = (page - 1) * limit
        stmt = (
            select(Session)
            .where(Session.course_id == course_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.scalars().all()
