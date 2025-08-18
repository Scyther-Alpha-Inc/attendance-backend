from app.models.course import Course
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from uuid import UUID


class CourseRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create(self, course: Course):
        try:
            self.session.add(course)
            await self.session.commit()
            await self.session.refresh(course)
            return course
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def by_id(self, id: UUID):
        return await self.session.get(Course, id)
    