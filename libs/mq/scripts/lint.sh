#!/bin/bash
set -e

mypy mq
ruff mq
black mq --check
