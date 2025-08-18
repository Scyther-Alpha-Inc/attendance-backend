from sqlmodel import SQLModel, Field

from app.enums.session_environment import SessionEnvironment
from uuid import UUID
from uuid import uuid4


class Session(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default=lambda: uuid4())
    session_type: SessionEnvironment
    lecturer_id: UUID = Field(foreign_key="user.id")
    class_id: UUID = Field(foreign_key="class.id")
