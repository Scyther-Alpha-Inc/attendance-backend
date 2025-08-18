from starlette.requests import empty_receive, empty_send
from starlette.types import Receive, Scope, Send
from typing import Union
from fastapi import Request

from app.models.admin import Admin


class AdminRequest(Request):
    def __init__(
        self,
        admin_id: Union[str, None],
        admin_profile_id: Union[str, None],
        scope: Scope,
        receive: Receive = ...,
        send: Send = ...,
    ):
        super.__init__(scope, receive, send)
        self.admin_id = admin_id

    admin: Admin
