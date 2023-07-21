import io
from unittest import mock

from mq.core import main


@mock.patch('sys.stdout', new_callable=io.StringIO)
def test_stdout(mock_stdout):
    main()
    assert mock_stdout.getvalue().strip() == "Go for mq version: 1.3.2"
