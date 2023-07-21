# Exit in case of error
set -e
TAG=${TAG:=latest}

INSTALL_TEST=true sh ./scripts/build.sh

docker run -i --rm -v "$PWD:/tmp" -w /tmp \
    app:$TAG pytest
