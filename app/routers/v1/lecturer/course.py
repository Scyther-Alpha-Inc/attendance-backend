from fastapi import APIRouter

from core.customs.user_request import UserRequest
from app.dependencies.controllers.lecturer.lecturer_course_controller import (
    LecturerCourseControllerDep,
)

courses_router = APIRouter(prefix="/courses", tags=["courses"])


@courses_router.get("/")
async def get_courses(
    course_controller: LecturerCourseControllerDep,
    request: UserRequest,
    page: int = 1,
    limit: int = 10,
):
    return await course_controller.get_courses(request.user_id, page, limit)
