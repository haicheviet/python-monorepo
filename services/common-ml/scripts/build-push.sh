# Exit in case of error
set -e

DOCKER_IMAGE=${DOCKER_IMAGE}
TAG=${TAG:=latest}

sh ./scripts/build.sh

echo "Push all image"
docker push $DOCKER_IMAGE:compile-stage-$TAG
docker push $DOCKER_IMAGE:$TAG
