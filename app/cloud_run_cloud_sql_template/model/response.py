from pydantic import BaseModel


class ResponseItem(BaseModel):
    payload: str
