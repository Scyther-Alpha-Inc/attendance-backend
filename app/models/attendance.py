from datetime import datetime
from .enrollment import Enrollment
from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from .session import Session

class Attendance(SQLModel, table=True):
    __tablename__ = "attendances"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    enrollment_id: UUID = Field(foreign_key="enrollments.id")
    session_id: UUID = Field(foreign_key="sessions.id")
    enrollment: Enrollment = Relationship()
    score: int = Field(default=0)
    created_at: datetime = Field(default_factory=datetime.now)
