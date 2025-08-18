from typing import List
from app.models.course import Course
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError
from uuid import UUID
from app.models.enrollment import Enrollment
from app.models.session import Session
from sqlalchemy import func
from sqlmodel import select
from app.schema.course import CourseDetailResponse


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

        # Create subqueries for accurate counts
        sessions_subquery = (
            select(func.count(Session.id))
            .where(Session.course_id == Course.id)
            .scalar_subquery()
        )

        enrollments_subquery = (
            select(func.count(Enrollment.id))
            .where(Enrollment.course_id == Course.id)
            .scalar_subquery()
        )

        stmt = (
            select(
                Course.id,
                Course.title,
                Course.code,
                Course.lecturer_id,
                Course.department_id,
                sessions_subquery.label("sessions_count"),
                enrollments_subquery.label("enrollments_count"),
            )
            .where(Course.lecturer_id == lecturer_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.session.execute(stmt)
        rows = result.all()

        # Convert rows to response objects
        courses = []
        for row in rows:
            courses.append(
                CourseDetailResponse(
                    id=row.id,
                    title=row.title,
                    code=row.code,
                    lecturer_id=row.lecturer_id,
                    department_id=row.department_id,
                    sessions_count=row.sessions_count,
                    enrollments_count=row.enrollments_count,
                )
            )

        return courses

    async def by_id(self, id: UUID):
        stmt = (
            select(
                Course.id,
                Course.title,
                Course.code,
                func.count(func.distinct(Session.id)).label("sessions_count"),
                func.count(func.distinct(Enrollment.id)).label("enrollments_count"),
            )
            .join(Session, Session.course_id == Course.id, isouter=True)
            .join(Enrollment, Enrollment.course_id == Course.id, isouter=True)
            .group_by(Course.id, Course.title, Course.code)
            .where(Course.id == id)
        )
        result = await self.session.execute(stmt)
        row = result.first()
        if row:
            return CourseDetailResponse(
                id=row.id,
                title=row.title,
                code=row.code,
                sessions_count=row.sessions_count,
                enrollments_count=row.enrollments_count,
            )
        return None

    async def bulk_create(self, courses: List[Course]):
        try:
            self.session.add_all(courses)
            await self.session.commit()
            return courses
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def first(self):
        stmt = select(Course).limit(1)
        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()
