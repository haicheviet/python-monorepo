FROM python:3.8.16-slim-buster as base-img

# Base working dir
WORKDIR /app


# This is the compile-image
FROM base-img AS compile-image

RUN apt-get update -qq && \
    apt-get update -y && \
    apt-get install curl -y

# Make sure we use the virtualenv:
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_VERSION=1.5.1 POETRY_HOME=/opt/poetry python3 && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false && \
    poetry config virtualenvs.prefer-active-python true

# Install dependency
ARG INSTALL_TEST=false
COPY poetry.lock pyproject.toml ./
COPY --from=telemetry . ../../libs/telemetry
RUN . /opt/venv/bin/activate && if [ $INSTALL_TEST != 'false' ] ; then poetry install --no-root --with test ; \
    else poetry install --no-root --only main ; fi

# Install service
ADD src ./src
RUN poetry build && pip install dist/*.tar.gz --no-deps

# This is the second and final image; it copies the compiled
# python package over but starts from the base image.
FROM base-img as runtime-image

COPY --from=compile-image /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

CMD [ "python" ]