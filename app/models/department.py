from typing import List
from app.models.course import Course
from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4


class Department(SQLModel, table=True):
    __tablename__ = "departments"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    name: str = Field(index=True, unique=True)
    code: str = Field(index=True, unique=True)
    courses: List[Course] = Relationship()