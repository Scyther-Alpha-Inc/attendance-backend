from typing import List
from pydantic import BaseModel
from app.enums.user_role import UserRole


class UserCreateInput(BaseModel):
    gctu_id: str
    name: str
    email: str
    role: UserRole


class UserBulkCreateInput(BaseModel):
    users: List[UserCreateInput]
