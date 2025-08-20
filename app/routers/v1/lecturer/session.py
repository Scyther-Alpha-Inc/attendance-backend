from fastapi import APIRouter, Depends
from pydantic import UUID4
from app.controllers.lecturer.lecturer_session import LecturerSessionController
from app.dependencies.controllers.lecturer.lecturer_session import (
    LecturerSessionControllerDep,
)
from app.dependencies.role_verifier.lecturer_verifier import lecturer_verifier
from app.schema.session import SessionInput

session_router = APIRouter(
    prefix="/session",
    tags=["session"],
    dependencies=[Depends(lecturer_verifier)],
)


@session_router.post(
    "/create",
)
async def create_session(
    session_input: SessionInput,
    lecturer_session_controller: LecturerSessionControllerDep,
):
    return await lecturer_session_controller.create_session(session_input)


@session_router.get(
    "/{id}",
)
async def get_session(
    id: UUID4,
    lecturer_session_controller: LecturerSessionControllerDep,
):
    data = await lecturer_session_controller.get_session(id)
    print(data)
    return data


@session_router.get(
    "/courses/{course_id}",
)
async def get_sessions_by_course(
    course_id: UUID4,
    lecturer_session_controller: LecturerSessionControllerDep,
):
    return await lecturer_session_controller.get_sessions_by_course(course_id)


@session_router.get(
    "/attendance/{session_id}",
)
async def get_attendance_by_session_id(
    session_id: UUID4,
    lecturer_session_controller: LecturerSessionControllerDep,
):
    return await lecturer_session_controller.get_attendance_by_session_id(session_id)

@session_router.get(
    "/enrolled-students/{session_id}",
)
async def get_session_details(
    session_id: UUID4,
    lecturer_session_controller: LecturerSessionControllerDep,
):
    data = await lecturer_session_controller.get_session(session_id)
    print(data)
    return data