from http import HTTPStatus
from pydantic import UUID4
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.course_repo import CourseRepo
from core.exceptions.simple_exception import SimpleException


class LecturerCourseController:
    def __init__(self, session: AsyncSession):
        self.__course_repo = CourseRepo(session)

    async def get_courses(self, lecturer_id: UUID4, page: int = 1, limit: int = 10):
        return await self.__course_repo.by_lecturer_id(lecturer_id, page, limit)

    async def get_course(self, course_id: UUID4):
        course = await self.__course_repo.by_id(course_id)
        print(course)
        if not course:
            raise SimpleException(
                HTTPStatus.NOT_FOUND,
                "Course not found",
            )
        return course