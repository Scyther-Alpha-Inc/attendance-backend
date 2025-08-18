from typing import List

from app.enums.session_environment import SessionEnvironment
from .attendance import Attendance
from sqlmodel import SQLModel, Field, Relationship

from uuid import UUID
from uuid import uuid4


class Session(SQLModel, table=True):
    __tablename__ = "sessions"
    id: UUID = Field(primary_key=True)
    session_type: SessionEnvironment
    course_id: UUID = Field(foreign_key="courses.id")
    attendances: List[Attendance] = Relationship()
