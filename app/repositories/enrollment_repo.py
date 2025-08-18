from sqlmodel import select
from app.models.enrollment import Enrollment
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.ext.asyncio import AsyncSession


class EnrollmentRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def bulk_create(self, enrollment_models: list[Enrollment]):
        try:
            self.session.add_all(enrollment_models)
            await self.session.commit()
            return enrollment_models
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e