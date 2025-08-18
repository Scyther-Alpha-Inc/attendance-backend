from pydantic import BaseModel

from app.enums.user_role import UserRole


class UserAuthOutput(BaseModel):
    token: str
    role: UserRole


class UserLoginInput(BaseModel):
    gctu_id: str
    pin: str