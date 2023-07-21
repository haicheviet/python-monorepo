#!/bin/bash
set -x

ruff mq --fix
black mq
