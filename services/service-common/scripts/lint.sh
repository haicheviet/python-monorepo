#!/bin/bash
set -e

mypy service_common
ruff service_common
black service_common --check
