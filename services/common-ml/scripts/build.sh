# Exit in case of error
set -e

TAG=${TAG:=latest}
INSTALL_TEST=${INSTALL_TEST:=false}

# Build the compile stage:
docker buildx build --file Dockerfile \
       --target compile-image \
       --label git-commit=$CI_COMMIT_SHORT_SHA \
       --build-arg INSTALL_TEST="$INSTALL_TEST" \
       --build-context telemetry=../../libs/telemetry \
       --cache-from common-ml:compile-stage-$TAG \
       --tag common-ml:compile-stage-$TAG .


# Build the runtime stage, using cached compile stage:
docker buildx build --file Dockerfile \
       --target runtime-image \
       --label git-commit=$CI_COMMIT_SHORT_SHA \
       --build-arg INSTALL_TEST="$INSTALL_TEST" \
       --build-context telemetry=../../libs/telemetry \
       --cache-from common-ml:compile-stage-$TAG \
       --cache-from common-ml:$TAG \
       --tag common-ml:$TAG .
