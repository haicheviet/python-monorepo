#!/bin/bash
set -e

mypy ml
ruff ml
black ml --check
