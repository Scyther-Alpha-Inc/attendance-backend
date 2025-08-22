from typing import List, Optional
from datetime import datetime
from app.enums.session_environment import SessionEnvironment
from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4
from .course import Course


class Session(SQLModel, table=True):
    __tablename__ = "sessions"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    session_type: SessionEnvironment
    ref_id: str = Field(default=None)
    course_id: UUID = Field(foreign_key="courses.id")
    attendances: List["Attendance"] = Relationship()
    course: Course = Relationship(back_populates="sessions")
    started_at: Optional[datetime] = Field(default=None)
    ended_at: Optional[datetime] = Field(default=None)
    created_at: datetime = Field(default_factory=datetime.now)
