from uuid import UUID
from sqlmodel import SQLModel, Field, Relationship
from uuid import uuid4
from app.models.course import Course
from app.models.user import User


class Class(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default=lambda: uuid4())
    name: str
    course_id: UUID = Field(foreign_key="course.id")
    course: Course = Relationship(back_populates="classes")
    lecturer: User = Relationship(back_populates="classes")

