#!/bin/bash
set -e

mypy telemetry
ruff telemetry
black telemetry --check
