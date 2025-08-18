from pydantic import BaseModel
from uuid import UUID


class CourseDetailResponse(BaseModel):
    id: UUID
    title: str
    code: str
    sessions_count: int
    enrollments_count: int
