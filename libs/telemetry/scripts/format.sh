#!/bin/bash

set -x

autoflake --ignore-init-module-imports --remove-all-unused-imports --recursive --remove-unused-variables --in-place telemetry
black telemetry
isort telemetry