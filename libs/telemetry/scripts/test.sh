# Exit in case of error
set -e
TAG=${TAG?Variable not set}

INSTALL_TEST=true sh ./scripts/build.sh

docker run -i --rm -v "$PWD:/tmp" -w /tmp \
    telemetry:$TAG pytest
