import io
from unittest import mock

from service_common.main import main


@mock.patch("sys.stdout", new_callable=io.StringIO)
def test_stdout(mock_stdout):
    main()
    assert mock_stdout.getvalue().strip() == "Go for opentelemetry"
