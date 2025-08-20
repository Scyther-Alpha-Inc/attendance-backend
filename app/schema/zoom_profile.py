from pydantic import BaseModel, Field, HttpUrl
from typing import List, Optional
from datetime import datetime


class ZoomUserProfile(BaseModel):
    """Model for Zoom user profile data"""

    # Basic user information
    id: str
    first_name: str
    last_name: str
    display_name: str
    email: str

    # User type and role information
    type: int
    role_name: str
    role_id: str

    # Personal Meeting Information (PMI)
    pmi: int
    use_pmi: bool
    personal_meeting_url: HttpUrl

    # Account and system information
    timezone: str
    verified: int
    dept: str = ""
    account_id: str
    account_number: Optional[int] = None
    cluster: str

    # Timestamps
    created_at: datetime
    user_created_at: datetime
    last_login_time: datetime

    # Client and system details
    last_client_version: str
    pic_url: HttpUrl
    cms_user_id: str = ""
    jid: str

    # Groups and associations
    group_ids: List[str] = Field(default_factory=list)
    im_group_ids: List[str] = Field(default_factory=list)
    login_types: List[int]

    # Localization and contact
    language: str
    phone_country: str = ""
    phone_number: str = ""

    # Status and profile details
    status: str
    job_title: str = ""
    cost_center: str = ""
    location: str = ""

    class Config:
        # Allow parsing datetime strings
        json_encoders = {datetime: lambda v: v.isoformat()}

    @property
    def full_name(self) -> str:
        """Get the user's full name"""
        return f"{self.first_name} {self.last_name}"

    @property
    def is_verified(self) -> bool:
        """Check if the user is verified"""
        return self.verified == 1

    @property
    def is_active(self) -> bool:
        """Check if the user status is active"""
        return self.status.lower() == "active"

    @property
    def is_owner(self) -> bool:
        """Check if the user is an owner"""
        return self.role_name.lower() == "owner"

    @property
    def has_phone(self) -> bool:
        """Check if the user has a phone number"""
        return bool(self.phone_number.strip())

    @property
    def has_groups(self) -> bool:
        """Check if the user belongs to any groups"""
        return len(self.group_ids) > 0 or len(self.im_group_ids) > 0

    def get_meeting_url_with_password(self) -> str:
        """Get the personal meeting URL (already includes password in the sample)"""
        return str(self.personal_meeting_url)
