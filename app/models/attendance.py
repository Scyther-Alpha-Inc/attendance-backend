from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4
from ..models.session import Session
from ..models.user import User


class Attendance(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default=lambda: uuid4())
    session_id: UUID = Field(foreign_key="session.id")
    student_id: UUID = Field(foreign_key="user.id")
    session: Session = Relationship(back_populates="attendances")
    student: User = Relationship(back_populates="attendances")
