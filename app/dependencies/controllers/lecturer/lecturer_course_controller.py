from typing import Annotated
from fastapi import Depends
from app.controllers.lecturer.courses import (
    LecturerCourseController,
)
from app.db.database_session import sessionmanager
from app.dependencies.db.db_session_dep import DBSessionDep


def lecturer_course_controller(
    session: DBSessionDep,
) -> LecturerCourseController:
    return LecturerCourseController(session)


LecturerCourseControllerDep = Annotated[
    LecturerCourseController, Depends(lecturer_course_controller)
]
