from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID
from uuid import uuid4


class Attendance(SQLModel, table=True):
    __tablename__ = "attendances"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    session_id: UUID = Field(foreign_key="sessions.id")
    student_id: UUID = Field(foreign_key="users.id")
    
    