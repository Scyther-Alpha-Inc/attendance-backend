from fastapi import APIRouter, Depends
from pydantic import UUID4

from app.dependencies.controllers.lecturer.lecturer_session import LecturerSessionControllerDep
from app.dependencies.role_verifier.lecturer_verifier import lecturer_verifier
from core.customs.user_request import UserRequest
from app.dependencies.controllers.lecturer.lecturer_course_controller import (
    LecturerCourseControllerDep,
)

courses_router = APIRouter(
    prefix="/courses",
    tags=["courses"],
    dependencies=[Depends(lecturer_verifier)],
)

@courses_router.get(
    "/{course_id}/sessions",
)
async def get_sessions_by_course(
    course_id: UUID4,
    lecturer_session_controller: LecturerSessionControllerDep,
):
    return await lecturer_session_controller.get_sessions_by_course(course_id)


@courses_router.get("/")
async def get_courses(
    course_controller: LecturerCourseControllerDep,
    request: UserRequest,
    page: int = 1,
    limit: int = 10,
):
    return await course_controller.get_courses(request.user_id, page, limit)


@courses_router.get("/{course_id}")
async def get_course(
    course_id: UUID4,
    course_controller: LecturerCourseControllerDep,
):
    return await course_controller.get_course(course_id)