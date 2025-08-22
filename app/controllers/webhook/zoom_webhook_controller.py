from http import HTTPStatus
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.session import Session
from app.repositories.course_repo import CourseRepo
from app.repositories.social_auth import SocialAuthRepo
from app.schema.zoom_webhook import ZoomWebhookEvent
from core.exceptions.simple_exception import SimpleException


class ZoomWebhookController:
    def __init__(self, session: AsyncSession) -> None:
        self.session = session
        self._social_auth_repo = SocialAuthRepo(session)
        self._course_repo = CourseRepo(session)

    async def handle_webhook(self, webhook_event: ZoomWebhookEvent) -> None:
        if webhook_event.event == "meeting.participant_joined":
            oauth_id = webhook_event.payload.account_id
            social_auth = await self._social_auth_repo.get_by_oauth_id(oauth_id)
            if not social_auth:
                """TODO: check attendance for user here."""
                raise SimpleException(
                    status_code=HTTPStatus.NOT_FOUND,
                    message="User not found",
                )
            course_code = webhook_event.payload.topic.split("-")[-1].strip()
            course = await self._course_repo.get_by_code(course_code)
            if not course:
                raise SimpleException(
                    status_code=HTTPStatus.NOT_FOUND,
                    message="Course not found",
                )
            user_id = social_auth.user_id
            session = Session(
                ref_id=webhook_event.payload.id,
                user_id=user_id,
                course_id=course.id,
                session_type=webhook_event.payload.meeting.type,
                started_at=webhook_event.payload.meeting.start_time,
                ended_at=webhook_event.payload.meeting.end_time,
            )
            self.session.add(session)
            await self.session.commit()
            print(user_id)

        print(webhook_event)
