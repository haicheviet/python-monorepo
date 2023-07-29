# Exit in case of error
set -e

DOCKER_IMAGE=${DOCKER_IMAGE:=latest}
TAG=${TAG:=latest}
INSTALL_TEST=${INSTALL_TEST:=false}


# Get latest image to reuse compile stage
if [ "$(docker images -q $DOCKER_IMAGE:compile-stage-$TAG 2>/dev/null)" != "" ]; then
       TAG_LATEST=$TAG
       echo "Get exist img"
else
       docker pull $DOCKER_IMAGE:compile-stage-$TAG_LATEST || true
       echo "Get latest img"
fi


# Build the compile stage:
docker buildx build --file Dockerfile \
       --target compile-image \
       --label git-commit=$CI_COMMIT_SHORT_SHA \
       --build-arg INSTALL_TEST="$INSTALL_TEST" \
       --build-context telemetry=../../libs/telemetry \
       --build-context ml=../../libs/ml \
       --build-context mq=../../libs/mq \
       --cache-from $DOCKER_IMAGE:compile-stage-$TAG_LATEST \
       --tag $DOCKER_IMAGE:compile-stage-$TAG .


# Build the runtime stage, using cached compile stage:
docker buildx build --file Dockerfile \
       --target runtime-image \
       --label git-commit=$CI_COMMIT_SHORT_SHA \
       --build-arg INSTALL_TEST="$INSTALL_TEST" \
       --build-context telemetry=../../libs/telemetry \
       --build-context ml=../../libs/ml \
       --build-context mq=../../libs/mq \
       --cache-from $DOCKER_IMAGE:compile-stage-$TAG \
       --cache-from $DOCKER_IMAGE:$TAG \
       --tag $DOCKER_IMAGE:$TAG .
