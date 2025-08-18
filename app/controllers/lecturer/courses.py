from pydantic import UUID4
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.course_repo import CourseRepo


class LecturerCourseController:
    def __init__(self, session: AsyncSession):
        self.__course_repo = CourseRepo(session)

    async def get_courses(self, lecturer_id: UUID4, page: int = 1, limit: int = 10):
        return await self.__course_repo.by_lecturer_id(lecturer_id, page, limit)
