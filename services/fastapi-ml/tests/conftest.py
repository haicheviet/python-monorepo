from typing import Any, Generator

import pytest
from fastapi.testclient import TestClient

from app.main import app


@pytest.fixture()
def client() -> Generator[TestClient, Any, None]:
    with TestClient(app) as client:
        yield client
