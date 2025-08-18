from sqlmodel import SQLModel, Field
from app.enums.user_role import UserRole
from uuid import UUID
from uuid import uuid4


class User(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default=lambda: uuid4())
    gctu_id: str = Field(unique=True)
    name: str = Field(index=True)
    email: str = Field(unique=True, index=True)
    role: UserRole
