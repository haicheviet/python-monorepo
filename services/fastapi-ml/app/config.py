from importlib.metadata import version

from pydantic import BaseSettings


class Settings(BaseSettings):
    API_V1_STR: str = "/v1"
    PROJECT_NAME: str = "ml-template"
    VERSION: str = version("app")


settings = Settings()
