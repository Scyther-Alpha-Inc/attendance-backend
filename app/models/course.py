from sqlmodel import SQLModel, Field
from uuid import UUID
from uuid import uuid4


class Course(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default=lambda: uuid4())
    name: str  # eg: Algebra
    code: str  # eg: CS234
