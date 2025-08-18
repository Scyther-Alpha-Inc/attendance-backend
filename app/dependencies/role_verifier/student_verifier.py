from fastapi import Depends, HTTPException
from app.dependencies.user_jwt_verifier import user_jwt_verifier
from app.enums.user_role import UserRole
from app.models.user import User


async def student_verifier(
    user: User = Depends(user_jwt_verifier),
):
    if user.role != UserRole.STUDENT:
        raise HTTPException(status_code=403, detail="Forbidden")
