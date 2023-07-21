#!/bin/bash
set -e

mypy app
ruff app
black app --check
