from pydantic_settings import BaseSettings
from functools import lru_cache


class EnvSettings(BaseSettings):

    TOKEN_SECRET: str
    SQL_DB_USERNAME: str
    SQL_DB_PASSWORD: str
    SQL_DB_HOST: str
    SQL_DB_NAME: str
    REDDIS_HOST: str
    REDDIS_PORT: str
    REFRESH_TOKEN_EXP_MINS: int
    BACKEND_PORT: int
    SQL_DB_PORT: int
    REFRESH_EXPIRES_IN_MIN: int
    ACCESS_EXPIRES_IN_MIN: int
    ZOOM_CLIENT_ID: str
    ZOOM_CLIENT_SECRET: str

    class Config:
        env_file = ".env"
        case_sesitive = True
        extra = "ignore"

@lru_cache()
def get_environment_settings() -> EnvSettings:
    return EnvSettings()  # type: ignore


EnvironmentSettings = get_environment_settings()
