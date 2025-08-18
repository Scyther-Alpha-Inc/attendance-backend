from fastapi import Depends, HTTPException
from app.dependencies.user_jwt_verifier.user_jwt_verifier import user_jwt_verifier
from app.enums.user_role import UserRole
from core.customs.user_request import UserRequest


async def lecturer_verifier(
    request: UserRequest,
    user_jwt_verifier=Depends(user_jwt_verifier),
):
    if request.current_user.role != UserRole.LECTURER:
        raise HTTPException(status_code=403, detail="Forbidden")
