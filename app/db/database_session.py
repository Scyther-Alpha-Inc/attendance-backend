import contextlib
from sqlmodel import create_engine, SQLModel
from typing import Any, AsyncIterator
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from core.env_settings import EnvironmentSettings
from ..models.attendance import Attendance
from ..models.course import Course
from ..models.session import Session
from ..models.user import User
from ..models.enrollment import Enrollment


class DatabaseSessionManager:
    def __init__(self, host: str, engine_kwargs: dict[str, Any] = {}):
        self._engine = create_async_engine(host, future=True, **engine_kwargs)
        self._sessionmaker = async_sessionmaker(
            self._engine,
            class_=AsyncSession,
            expire_on_commit=False,
        )

    async def close(self):
        if self._engine is None:
            raise Exception("DatabaseSessionManager is not initialized")
        await self._engine.dispose()
        self._engine = None
        self._sessionmaker = None

    async def init_models(self):
        async with self._engine.begin() as conn:
            await conn.run_sync(SQLModel.metadata.create_all)

    @contextlib.asynccontextmanager
    async def session(self) -> AsyncIterator[AsyncSession]:
        if self._sessionmaker is None:
            raise Exception("DatabaseSessionManager is not initialized")

        async with self._sessionmaker() as session:
            try:
                yield session
            except Exception:
                await session.rollback()
                raise


sessionmanager = DatabaseSessionManager(
    f"postgresql+asyncpg://{EnvironmentSettings.SQL_DB_USERNAME}:{EnvironmentSettings.SQL_DB_PASSWORD}@{EnvironmentSettings.SQL_DB_HOST}:{EnvironmentSettings.SQL_DB_PORT}/{EnvironmentSettings.SQL_DB_NAME}"
)


async def get_db_session():
    async with sessionmanager.session() as session:
        yield session
