#!/bin/bash
set -x

ruff src --fix
black src
