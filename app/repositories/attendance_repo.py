from app.models.attendance import Attendance
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError


class AttendanceRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create(self, attendance: Attendance):
        try:
            self.session.add(attendance)
            await self.session.commit()
            await self.session.refresh(attendance)
            return attendance
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def bulk_create(self, attendances: list[Attendance]):
        try:
            self.session.add_all(attendances)
            await self.session.commit()
            return attendances
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e
