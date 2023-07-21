from http import HTTPStatus
from importlib.metadata import version

import pytest
from fastapi.testclient import TestClient

from app.config import settings
from tests.constants import ADD_OPERATOR_URL, GET_MQ_VERSION_URL


def test_main_api(client: TestClient):
    response = client.get("/")
    assert response.status_code == HTTPStatus.OK
    data = response.json()
    assert data["body"] == f"app version: {settings.VERSION}"


@pytest.mark.parametrize(argnames=["a", "b", "expected_result"], argvalues=[(1., 2., 3.)])
def test_add_operator(client: TestClient, a: float, b: float, expected_result: float):
    response = client.get(ADD_OPERATOR_URL, params={"a": a, "b": b})
    assert response.status_code == HTTPStatus.OK
    data = response.json()
    assert data == expected_result


def test_get_mq_version(client: TestClient):
    response = client.get(GET_MQ_VERSION_URL)
    assert response.status_code == HTTPStatus.OK
    data = response.json()
    assert data == version("mq")
