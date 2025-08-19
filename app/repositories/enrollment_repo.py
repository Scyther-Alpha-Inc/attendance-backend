from sqlmodel import select
from app.models.enrollment import Enrollment
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.ext.asyncio import AsyncSession
from uuid import UUID
from pydantic import UUID4


class EnrollmentRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def bulk_create(self, enrollment_models: list[Enrollment]):
        try:
            self.session.add_all(enrollment_models)
            await self.session.commit()
            return enrollment_models
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def bulk_fetch_by_student_ids(self, student_ids: list[UUID4]):
        try:
            statement = select(Enrollment).where(Enrollment.student_id.in_(student_ids))
            result = await self.session.execute(statement)
            return result.scalars().all()
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def get_distinct_student_ids(self) -> list[UUID]:
        """Fetch all distinct student IDs from enrollments"""
        try:
            statement = select(Enrollment.student_id).distinct()
            result = await self.session.execute(statement)
            return result.scalars().all()
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def get_distinct_student_ids_by_course(self, course_id: UUID) -> list[UUID]:
        """Fetch distinct student IDs enrolled in a specific course"""
        try:
            statement = (
                select(Enrollment.student_id)
                .where(Enrollment.course_id == course_id)
                .distinct()
            )
            result = await self.session.execute(statement)
            return result.scalars().all()
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def get_student_course_count(self, student_id: UUID) -> int:
        """Get the number of courses a student is enrolled in"""
        try:
            from sqlalchemy import func

            statement = select(func.count(Enrollment.course_id)).where(
                Enrollment.student_id == student_id
            )
            result = await self.session.execute(statement)
            return result.scalar() or 0
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e
