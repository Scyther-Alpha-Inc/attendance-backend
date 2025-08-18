from typing import Any, Awaitable, Callable, MutableMapping, Union
from fastapi import Request
from app.models.user import User
from uuid import UUID


class UserRequest(Request):
    def __init__(
        self,
        user_id: Union[UUID, None],
        user: Union[User, None],
        scope: MutableMapping[str, Any],
        receive: Callable[[], Awaitable[MutableMapping[str, Any]]] = ...,
        send: Callable[[MutableMapping[str, Any]], Awaitable[None]] = ...,
    ):
        super().__init__(scope, receive, send),
        self.user_id = user_id
        self.user = user

    user: User
