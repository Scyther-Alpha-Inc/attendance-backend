from fastapi import Depends
from typing import Annotated
from app.controllers.lecturer.lecturer_session import LecturerSessionController
from app.dependencies.db.db_session_dep import DBSessionDep


def lecturer_session_controller(db_session: DBSessionDep):
    return LecturerSessionController(db_session)


LecturerSessionControllerDep = Annotated[
    LecturerSessionController, Depends(lecturer_session_controller)
]
