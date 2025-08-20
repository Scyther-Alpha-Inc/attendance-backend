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
            select(Attendance, User)
            .join(Enrollment, Attendance.enrollment_id == Enrollment.id)
            .join(User, Enrollment.student_id == User.id)
            .where(Attendance.session_id == session_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        attendance_with_users = []

        for attendance, user in result.all():
            attendance_dict = {
                "id": str(attendance.id),
                "enrollment_id": str(attendance.enrollment_id),
                "session_id": str(attendance.session_id),
                "score": attendance.score,
                "created_at": attendance.created_at,
                "student": {
                    "id": str(user.id),
                    "gctu_id": user.gctu_id,
                    "name": user.name,
                    "email": user.email,
                    "role": user.role,
                },
            }
            attendance_with_users.append(attendance_dict)

        return attendance_with_users

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
            .outerjoin(Attendance, Attendance.session_id == session_id)
            .where(Enrollment.course_id == session.course_id)
            .limit(limit)
            .offset(offset)
        )
        result = await self.__session.execute(stmt)
        return result.scalars().all()

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

    async def get_session_attendance_summary(self, session_id: UUID):
        """Get session with total enrolled, present, and absent counts"""
        from sqlalchemy import func

        # First get the session to find the course_id
        session_stmt = select(Session).where(Session.id == session_id)
        session_result = await self.__session.execute(session_stmt)
        session = session_result.scalar_one_or_none()

        if not session:
            return None

        # Get aggregated statistics
        stmt = (
            select(
                Session.id.label("session_id"),
                Session.course_id,
                Session.session_type,
                Session.created_at.label("session_created_at"),
                func.count(Enrollment.id).label("total_enrolled"),
                func.count(Attendance.id).label("total_present"),
                (func.count(Enrollment.id) - func.count(Attendance.id)).label(
                    "total_absent"
                ),
            )
            .select_from(Session)
            .join(Enrollment, Session.course_id == Enrollment.course_id)
            .outerjoin(
                Attendance,
                (Attendance.enrollment_id == Enrollment.id)
                & (Attendance.session_id == session_id),
            )
            .where(Session.id == session_id)
            .group_by(
                Session.id, Session.course_id, Session.session_type, Session.created_at
            )
        )

        result = await self.__session.execute(stmt)
        row = result.first()

        if not row:
            return None

        # Get enrolled students using subquery
        students_stmt = (
            select(User)
            .join(Enrollment, User.id == Enrollment.student_id)
            .where(Enrollment.course_id == session.course_id)
        )
        students_result = await self.__session.execute(students_stmt)
        students = students_result.scalars().all()

        # Convert students to dictionaries
        users_list = []
        for student in students:
            users_list.append(
                {
                    "id": str(student.id),
                    "gctu_id": student.gctu_id,
                    "name": student.name,
                    "email": student.email,
                    "role": student.role,
                }
            )

        # Convert to dictionary for JSON serialization
        return {
            "session_id": str(row.session_id),
            "course_id": str(row.course_id),
            "session_type": row.session_type,
            "session_created_at": row.session_created_at,
            "total_enrolled": row.total_enrolled,
            "total_present": row.total_present,
            "total_absent": row.total_absent,
            "users": users_list,
        }
