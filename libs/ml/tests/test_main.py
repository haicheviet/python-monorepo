import io
from unittest import mock

import pytest
import torch

from ml.core import call_telemetry_function, sum_two_tensor


@pytest.mark.parametrize(
    argnames=["a", "b", "expected_result"], argvalues=[(1, 2, 3), (0.1, 0.2, 0.3)]
)
def test_sum(a, b, expected_result):
    a = torch.tensor(a)
    b = torch.tensor(b)
    expected_result = torch.tensor(expected_result)

    result = sum_two_tensor(a, b)
    assert torch.equal(result, expected_result)


@mock.patch("sys.stdout", new_callable=io.StringIO)
def test_call_sublib(mock_stdout):
    call_telemetry_function()
    assert mock_stdout.getvalue().strip() == "Go for opentelemetry"
