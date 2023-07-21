from importlib.metadata import version

import pydantic
import torch
from fastapi import FastAPI
from ml.core import sum_two_tensor

from app.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME, openapi_url=f"{settings.API_V1_STR}/openapi.json"
)


class Msg(pydantic.BaseModel):
    body: str


@app.get("/")
async def read_item() -> Msg:
    return Msg(body=f"app version: {settings.VERSION}")


@app.get("/add-operator")
async def add_operator(a: float, b: float) -> float:
    result: float = sum_two_tensor(torch.tensor(a), torch.tensor(b)).item()
    return result


@app.get("/get-mq-version")
async def get_mq_version() -> str:
    return version("mq")
