from app.models.social_auth import SocialAuth
from sqlmodel import SQLModel, Field, Relationship, select
from uuid import UUID, uuid4
from sqlalchemy.ext.asyncio import AsyncSession


class SocialAuthRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create(self, social_auth: SocialAuth):
        self.session.add(social_auth)
        await self.session.commit()
        await self.session.refresh(social_auth)
        return social_auth

    async def get_by_oauth_id(self, oauth_id: str) -> SocialAuth:
        result = await self.session.execute(
            select(SocialAuth).where(SocialAuth.oauth_id == oauth_id)
        )
        return result.scalar_one_or_none()
