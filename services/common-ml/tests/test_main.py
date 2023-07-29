import io
from unittest import mock

from src.main import main
import runpy


@mock.patch("sys.stdout", new_callable=io.StringIO)
def test_stdout(mock_stdout):
    main()
    assert mock_stdout.getvalue().strip() == "Go for opentelemetry"

@mock.patch("sys.stdout", new_callable=io.StringIO)
def test_execute_file(mock_stdout):
    runpy._run_module_as_main("src.main")
    assert mock_stdout.getvalue().strip() == "Go for opentelemetry"

