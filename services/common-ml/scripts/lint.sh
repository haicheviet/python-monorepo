#!/bin/bash
set -e

mypy src
ruff src
black src --check
