from sqlmodel import SQLModel, Field, Relationship
from uuid import UUID, uuid4


class SocialAuth(SQLModel, table=True):
    __tablename__ = "social_auths"

    id: UUID = Field(primary_key=True, default_factory=uuid4)
    user_id: UUID = Field(foreign_key="users.id")
    oauth_id: str = Field(index=True, unique=True)
    provider: str
    access_token: str
    refresh_token: str
