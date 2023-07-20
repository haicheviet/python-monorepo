#!/bin/bash

set -e

black --check telemetry
isort --check-only telemetry
flake8 telemetry
mypy telemetry