from datetime import datetime
from typing import List
from app.models.user import User
from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID, uuid4


class Enrollment(SQLModel, table=True):
    __tablename__ = "enrollments"

    id: UUID = Field(primary_key=True, default_factory=uuid4)

    student_id: UUID = Field(foreign_key="users.id")

    course_id: UUID = Field(foreign_key="courses.id")

    created_at: datetime = Field(default_factory=datetime.now)

    student: User = Relationship()