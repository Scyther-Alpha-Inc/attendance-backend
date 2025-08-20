from pydantic import UUID4
from app.controllers.user_auth import UserAuthController
from app.models.attendance import Attendance
from app.models.session import Session
from app.repositories.enrollment_repo import EnrollmentRepo
from app.repositories.session_repo import SessionRepo
from app.schema.session import SessionInput
from sqlalchemy.ext.asyncio import AsyncSession


class LecturerSessionController:
    def __init__(self, session: AsyncSession):
        self.__session_repo = SessionRepo(session)
        self.__enrollment_repo = EnrollmentRepo(session)

    async def create_session(self, session_input: SessionInput):
        attendances = []
        student_ids = [attendance.student_id for attendance in session_input.attendances]
        enrollments = await self.__enrollment_repo.bulk_fetch_by_student_ids(
            student_ids
        )

        for attendance in session_input.attendances:
            matching_enrollment = next(
                (e for e in enrollments if e.student_id == attendance.student_id), None
            )
            if not matching_enrollment:
                continue

            attendances.append(
                Attendance(
                    enrollment_id=matching_enrollment.id,
                    score=attendance.score,
                )
            )

        session = Session(
            session_type=session_input.session_type,
            id=session_input.id,
            course_id=session_input.course_id,
            attendances=attendances,
        )

        return await self.__session_repo.create(session)

    async def get_session(self, id: UUID4):
        return await self.__session_repo.get_session_attendance_summary(id)

    async def get_sessions_by_course(
        self, course_id: UUID4, page: int = 1, limit: int = 10
    ):
        return await self.__session_repo.get_by_course_id(course_id, page, limit)

    async def get_attendance_by_session_id(self, session_id: UUID4, page: int = 1, limit: int = 10):
        attendances = await self.__session_repo.get_attendance_by_session_id(session_id, page, limit)
        print("attendances")
        print(attendances)
        return attendances
    # async def get_sessions_by_lecturer(self, lecturer_id: UUID4):
    #     return await self.__session_repo.get_by_lecturer_id(lecturer_id)
