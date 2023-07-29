# Exit in case of error
set -e

DOCKER_IMAGE=${DOCKER_IMAGE}
TAG=${TAG:=latest}

INSTALL_TEST=true sh ./scripts/build.sh

echo "Push cached image"
docker push $DOCKER_IMAGE:compile-stage-$TAG

docker run -i --rm -v "$PWD:/tmp" -w /tmp \
    $DOCKER_IMAGE:$TAG pytest
