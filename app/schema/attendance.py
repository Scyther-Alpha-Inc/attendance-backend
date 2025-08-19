from pydantic import UUID4, BaseModel


class AttendanceInput(BaseModel):
    student_id: UUID4
    score: int
