from typing import List, Optional
from sqlmodel import SQLModel, Field, Relationship
from app.enums.user_role import UserRole
from uuid import UUID
from uuid import uuid4
from .enrollment import Enrollment


class User(SQLModel, table=True):
    __tablename__ = "users"
    id: UUID = Field(primary_key=True, default_factory=lambda: uuid4())
    gctu_id: str = Field(unique=True)
    name: str = Field(index=True)
    email: Optional[str] = Field(unique=True, index=True, nullable=True)
    role: UserRole
    pin: str
    enrollments: List[Enrollment] = Relationship()