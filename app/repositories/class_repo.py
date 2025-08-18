# from typing import List
# from app.models.class_model import Class
# from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy.exc import SQLAlchemyError


# class ClassRepo:
#     def __init__(self, session: AsyncSession):
#         self.session = session

#     async def create(self, class_model: Class):
#         try:
#             self.session.add(class_model)
#             await self.session.commit()
#             await self.session.refresh(class_model)
#             return class_model
#         except SQLAlchemyError as e:
#             await self.session.rollback()
#             raise e

#     async def bulk_create(self, class_models: List[Class]):
#         try:
#             self.session.add_all(class_models)
#             await self.session.commit()
#             return class_models
#         except SQLAlchemyError as e:
#             await self.session.rollback()
#             raise e
