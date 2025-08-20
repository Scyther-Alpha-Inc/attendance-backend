from sqlalchemy.orm import joinedload
from uuid import UUID
from app.models.attendance import Attendance
from app.models.enrollment import Enrollment
from app.models.session import Session
from app.models.user import User
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

    async def get_attendance_by_session_id(
        self, session_id: UUID, page: int = 1, limit: int = 10
    ):
        offset = (page - 1) * limit
        stmt = (
            select(Attendance)
            .join(Enrollment, Attendance.enrollment_id == Enrollment.id)
            .join(User, Enrollment.student_id == User.id)
            .group_by(Attendance.id, User.id)
            .where(Attendance.session_id == session_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.scalars().all()

    async def get_attendance_with_users_by_session_id(
        self, session_id: UUID, page: int = 1, limit: int = 10
    ):
        """Get attendance records with user information for a specific session"""
        offset = (page - 1) * limit
        stmt = (
            select(Attendance, User)
            .join(Enrollment, Attendance.enrollment_id == Enrollment.id)
            .join(User, Enrollment.student_id == User.id)
            .where(Attendance.session_id == session_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.all()

    async def get_enrolled_students_with_attendance_by_session_id(
        self, session_id: UUID, page: int = 1, limit: int = 10
    ):
        """Get all enrolled students for a session with their attendance records (if any)"""
        offset = (page - 1) * limit

        # First get the session to find the course_id
        session_stmt = select(Session).where(Session.id == session_id)
        session_result = await self.__session.execute(session_stmt)
        session = session_result.scalar_one_or_none()

        if not session:
            return []

        # Get enrolled students with left join to attendance
        stmt = (
            select(User, Attendance)
            .join(Enrollment, User.id == Enrollment.student_id)
            .outerjoin(
                Attendance,
                (Attendance.enrollment_id == Enrollment.id)
                & (Attendance.session_id == session_id),
            )
            .where(Enrollment.course_id == session.course_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.all()

    async def get_students_by_session_id(
        self, session_id: UUID, page: int = 1, limit: int = 10
    ):
        """Get all students enrolled in the course for a specific session"""
        offset = (page - 1) * limit

        # Get the session to find the course_id
        session_stmt = select(Session).where(Session.id == session_id)
        session_result = await self.__session.execute(session_stmt)
        session = session_result.scalar_one_or_none()

        if not session:
            return []

        # Get all students enrolled in this course
        stmt = (
            select(User)
            .join(Enrollment, User.id == Enrollment.student_id)
            .where(Enrollment.course_id == session.course_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.scalars().all()

    async def get_attendance_with_student_details_by_session_id(
        self, session_id: UUID, page: int = 1, limit: int = 10
    ):
        """Get attendance records with complete student information as a flat result"""
        offset = (page - 1) * limit
        stmt = (
            select(
                Attendance.id.label("attendance_id"),
                Attendance.session_id,
                Attendance.enrollment_id,
                Attendance.score,
                Attendance.created_at.label("attendance_created_at"),
                User.id.label("student_id"),
                User.gctu_id,
                User.name.label("student_name"),
                User.email.label("student_email"),
                User.role.label("student_role"),
            )
            .join(Enrollment, Attendance.enrollment_id == Enrollment.id)
            .join(User, Enrollment.student_id == User.id)
            .where(Attendance.session_id == session_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.all()
