# Exit in case of error
set -e

TAG=${TAG?Variable not set}
INSTALL_TEST=${INSTALL_TEST:=false}

# Build the compile stage:
docker buildx build --file Dockerfile \
       --target compile-image \
       --label git-commit=$CI_COMMIT_SHORT_SHA \
       --build-arg INSTALL_TEST="$INSTALL_TEST" \
       --cache-from telemetry:compile-stage-$TAG \
       --tag telemetry:compile-stage-$TAG .


# Build the runtime stage, using cached compile stage:
docker buildx build --file Dockerfile \
       --target runtime-image \
       --label git-commit=$CI_COMMIT_SHORT_SHA \
       --build-arg INSTALL_TEST="$INSTALL_TEST" \
       --cache-from telemetry:compile-stage-$TAG \
       --cache-from telemetry:$TAG \
       --tag telemetry:$TAG .
