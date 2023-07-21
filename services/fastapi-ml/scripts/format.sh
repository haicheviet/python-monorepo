#!/bin/bash
set -x

ruff app --fix
black app
