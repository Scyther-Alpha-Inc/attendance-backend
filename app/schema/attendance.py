from pydantic import UUID4, BaseModel


class AttendanceInput(BaseModel):
    enrollment_id: UUID4
    score: int
