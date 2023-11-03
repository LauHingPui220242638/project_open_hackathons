from pydantic import BaseModel


class InfoItem(BaseModel):
    chat: str = "Hello"
    kind: str = "map"
    coordinates: list = []

class Info(BaseModel):
    user_id: str = "AI"
    data: list[InfoItem] = []