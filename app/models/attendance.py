from datetime import datetime
from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4


class Attendance(SQLModel, table=True):
    __tablename__ = "attendances"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    enrollment_id: UUID = Field(foreign_key="enrollments.id")
    session_id: UUID = Field(foreign_key="sessions.id")

    created_at: datetime = Field(default_factory=datetime.now)