from fastapi import Depends, HTTPException
from app.dependencies.user_jwt_verifier.user_jwt_verifier import user_jwt_verifier
from app.enums.user_role import UserRole
from app.models.user import User


async def lecturer_verifier(
    user: User = Depends(user_jwt_verifier),
):
    if user.role != UserRole.LECTURER:
        raise HTTPException(status_code=403, detail="Forbidden")
