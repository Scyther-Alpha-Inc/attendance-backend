from typing import List
from uuid import UUID
from pydantic import UUID4, BaseModel

from app.enums.session_environment import SessionEnvironment
from app.schema.attendance import AttendanceInput


class SessionInput(BaseModel):
    id: UUID4
    session_type: SessionEnvironment
    class_id: UUID4
    attendances: List[AttendanceInput]
