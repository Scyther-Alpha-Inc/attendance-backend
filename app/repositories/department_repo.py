from typing import List
from app.models.department import Department
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.exc import SQLAlchemyError


class DepartmentRepo:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create(self, department: Department):
        try:
            self.session.add(department)

            await self.session.commit()
            await self.session.refresh(department)
            return department
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e

    async def bulk_create(self, departments: List[Department]):
        try:
            self.session.add_all(departments)
            await self.session.commit()
            await self.session.refresh(departments)
            return departments
        except SQLAlchemyError as e:
            await self.session.rollback()
            raise e