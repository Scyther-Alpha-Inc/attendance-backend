from pydantic import UUID4
from app.controllers.user_auth import UserAuthController
from app.models.attendance import Attendance
from app.models.session import Session
from app.repositories.session_repo import SessionRepo
from app.schema.session import SessionInput
from sqlalchemy.ext.asyncio import AsyncSession


class LecturerSessionController:
    def __init__(self, session: AsyncSession):
        self.__session_repo = SessionRepo(session)

    async def create_session(self, session_input: SessionInput):
        attendances = []
        for attendance in session_input.attendances:
            attendances.append(
                Attendance(
                    enrollment_id=attendance.enrollment_id,
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
        return await self.__session_repo.get_by_id(id)

    async def get_sessions_by_course(
        self, course_id: UUID4, page: int = 1, limit: int = 10
    ):
        return await self.__session_repo.get_by_course_id(course_id, page, limit)

    # async def get_sessions_by_lecturer(self, lecturer_id: UUID4):
    #     return await self.__session_repo.get_by_lecturer_id(lecturer_id)
