#!/bin/bash
set -x

ruff service_common --fix
black service_common
