from typing import List, Optional
from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4


class Course(SQLModel, table=True):
    __tablename__ = "courses"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    title: str  # eg: Algebra
    code: str  # eg: CS234
    lecturer_id: Optional[UUID] = Field(foreign_key="users.id", default=None)
    department_id: Optional[UUID] = Field(foreign_key="departments.id", default=None)
    sessions: List["Session"] = Relationship(back_populates="course")
