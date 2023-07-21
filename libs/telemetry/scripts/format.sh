#!/bin/bash
set -x

ruff telemetry --fix
black telemetry
