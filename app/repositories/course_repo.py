from typing import List
from app.models.course import Course
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from uuid import UUID
from sqlmodel import select


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

    async def by_lecturer_id(
        self,
        lecturer_id: UUID,
        page: int = 1,
        limit: int = 10,
    ):
        offset = (page - 1) * limit
        return await self.session.exec(
            select(Course)
            .where(Course.lecturer_id == lecturer_id)
            .offset(offset)
            .limit(limit)
        ).all()

    async def by_id(self, id: UUID):
        return await self.session.get(Course, id)

    async def bulk_create(self, courses: List[Course]):
        try:
            self.session.add_all(courses)
            await self.session.commit()
            return courses
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e
