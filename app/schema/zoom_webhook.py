from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class ZoomParticipant(BaseModel):
    """Model for Zoom meeting participant data"""

    public_ip: str
    user_id: str
    user_name: str
    participant_user_id: str
    id: str
    email: str
    participant_uuid: str

    # Fields that are present in participant_joined events
    join_time: Optional[datetime] = None

    # Fields that are present in participant_left events
    leave_time: Optional[datetime] = None
    registrant_id: Optional[str] = None
    leave_reason: Optional[str] = None
    private_ip: Optional[str] = None


class ZoomMeetingObject(BaseModel):
    """Model for Zoom meeting object data"""

    uuid: str
    participant: ZoomParticipant
    id: str
    type: int
    topic: str
    host_id: str
    duration: int
    start_time: datetime
    timezone: str


class ZoomWebhookPayload(BaseModel):
    """Model for Zoom webhook payload"""
    id: str
    account_id: str
    topic: str
    object: ZoomMeetingObject = Field(alias="object")


class ZoomWebhookEvent(BaseModel):
    """Main model for Zoom webhook events"""

    payload: ZoomWebhookPayload
    event_ts: int
    event: str

    class Config:
        allow_population_by_field_name = True

    @property
    def is_participant_joined(self) -> bool:
        """Check if this is a participant joined event"""
        return self.event == "meeting.participant_joined"

    @property
    def is_participant_left(self) -> bool:
        """Check if this is a participant left event"""
        return self.event == "meeting.participant_left"

    @property
    def participant_name(self) -> str:
        """Get the participant's name"""
        return self.payload.object.participant.user_name

    @property
    def meeting_id(self) -> str:
        """Get the meeting ID"""
        return self.payload.object.id

    @property
    def meeting_topic(self) -> str:
        """Get the meeting topic"""
        return self.payload.object.topic
