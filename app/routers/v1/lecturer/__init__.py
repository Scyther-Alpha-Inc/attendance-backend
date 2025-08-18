from fastapi import APIRouter
from .session import session_router
from .course import courses_router

lecturer_router = APIRouter(prefix="/lecturer", tags=["lecturer"])

lecturer_router.include_router(session_router)

lecturer_router.include_router(courses_router)
