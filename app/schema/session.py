from typing import List
from uuid import UUID
from pydantic import UUID4, BaseModel

from app.enums.session_environment import SessionEnvironment
from app.schema.attendance import AttendanceInput


class SessionInput(BaseModel):
    id: UUID4
    session_type: SessionEnvironment
    course_id: UUID4
    attendances: List[AttendanceInput]


class SessionOutput(BaseModel):
    id: UUID4
    session_type: SessionEnvironment
    course_id: UUID4
    attendance_count: int
    