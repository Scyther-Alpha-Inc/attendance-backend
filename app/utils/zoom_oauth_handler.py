from http import HTTPStatus
import aiohttp
from core.env_settings import EnvironmentSettings
from app.schema.zoom_profile import ZoomUserProfile
from core.exceptions.simple_exception import SimpleException


async def zoom_oauth_request(code: str) -> dict:
    auth = aiohttp.BasicAuth(
        EnvironmentSettings.ZOOM_CLIENT_ID, EnvironmentSettings.ZOOM_CLIENT_SECRET
    )
    url = f"https://zoom.us/oauth/token?grant_type=authorization_code&code={code}"
    async with aiohttp.ClientSession(auth=auth) as session:
        async with session.post(url) as response:
            return await response.json()


async def zoom_profile_request(access_token: str) -> ZoomUserProfile:
    url = f"https://api.zoom.us/v2/users/me"
    headers = {"Authorization": f"Bearer {access_token}"}
    async with aiohttp.ClientSession() as session:
        async with session.get(url, headers=headers) as response:
            if response.status != 200:
                raise SimpleException(HTTPStatus.BAD_REQUEST, "Invalid access token")
            return ZoomUserProfile.model_validate(await response.json())
