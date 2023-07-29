# Exit in case of error
set -e

DOCKER_IMAGE=${DOCKER_IMAGE}
TAG=${TAG:=latest}

INSTALL_TEST=true sh ./scripts/build-push.sh

docker run -i --rm -v "$PWD:/tmp" -w /tmp \
    $DOCKER_IMAGE:$TAG pytest
