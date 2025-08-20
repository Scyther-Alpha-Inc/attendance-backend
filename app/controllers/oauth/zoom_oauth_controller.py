from http import HTTPStatus
from uuid import UUID
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.social_auth import SocialAuth
from app.repositories.social_auth import SocialAuthRepo
from app.utils.zoom_oauth_handler import zoom_oauth_request, zoom_profile_request
from core.exceptions.simple_exception import SimpleException


class ZoomOauthController:
    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self.social_auth_repo = SocialAuthRepo(session)

    async def handle_oauth_callback(self, code: str,user_id:UUID) -> None:
        auth_token_response = await zoom_oauth_request(code)
        if not auth_token_response.get("access_token"):
            raise SimpleException(HTTPStatus.BAD_REQUEST, "Invalid code")

        zoom_profile_response = await zoom_profile_request(
            auth_token_response.get("access_token")
        )
        social_auth = await self.social_auth_repo.get_by_oauth_id(
            zoom_profile_response.id
        )
        if not social_auth:
            social_auth = SocialAuth(
                oauth_id=zoom_profile_response.id,
                user_id=user_id,
                provider="zoom",
                access_token=auth_token_response.get("access_token"),
                refresh_token=auth_token_response.get("refresh_token"),
            )
            social_auth = await self.social_auth_repo.create(social_auth)
        return social_auth
