FROM python:3.8.16-slim-buster as base-img

# Base working dir
WORKDIR /app

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
COPY poetry.lock pyproject.toml ./
RUN . /opt/venv/bin/activate && poetry install --no-root

# Install package
ADD telemetry ./
ARG INSTALL_TEST=false

RUN . /opt/venv/bin/activate && if [ $INSTALL_TEST != 'false' ] ; then poetry install --with test ; \
    else poetry install --only main ; fi

RUN . /opt/venv/bin/activate && python -c "import telemetry"

FROM base-img as runtime-image

COPY --from=compile-image /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

CMD ["python"]