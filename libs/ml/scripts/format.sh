#!/bin/bash
set -x

ruff ml --fix
black ml
