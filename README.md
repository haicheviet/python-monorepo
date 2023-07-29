
[![codecov](https://codecov.io/gh/haicheviet/python-monorepo/branch/main/graph/badge.svg?token=CIL7TY34M9)](https://codecov.io/gh/haicheviet/python-monorepo)

| Package      | Status | Coverage Page |
|------------- | ------ | ------------- |
|[libs/ml](https://github.com/haicheviet/python-monorepo/tree/main/libs/ml)| [![CI libs/ml](https://github.com/haicheviet/python-monorepo/actions/workflows/ci_lib_ml.yml/badge.svg)](https://github.com/haicheviet/python-monorepo/actions/workflows/ci_lib_ml.yml) | [ml.coverage](https://app.codecov.io/gh/haicheviet/python-monorepo/tree/main/libs%2Fml%2Fml) |
|[libs/mq](https://github.com/haicheviet/python-monorepo/tree/main/libs/mq)| [![CI libs/mq](https://github.com/haicheviet/python-monorepo/actions/workflows/ci_lib_mq.yml/badge.svg)](https://github.com/haicheviet/python-monorepo/actions/workflows/ci_lib_ml.yml) | [mq.coverage](https://app.codecov.io/gh/haicheviet/python-monorepo/tree/main/libs%2Fmq%2Fmq) |
|[libs/telemetry](https://github.com/haicheviet/python-monorepo/tree/main/libs/mq)| [![CI libs/telemetry](https://github.com/haicheviet/python-monorepo/actions/workflows/ci_lib_telemetry.yml/badge.svg)](https://github.com/haicheviet/python-monorepo/actions/workflows/ci_lib_ml.yml) | [telemetry.coverage](https://app.codecov.io/gh/haicheviet/python-monorepo/tree/main/libs%2Ftelemetry%2Ftelemetry) |

# Python Monorepo

This is an example of how python structure in monorepo fashion, with the goal of demonstrating:

 - `Scopes`: The folders act as scopes to make sure code artifacts are only visible when they should be. This allows to extract common tasks (e.g. building a C# solution) quickly and maintainers can easier reason about where the error lies.

 - `The One Version Rule (Atomic Commits)`. The principle guarantee that you can commit atomically to both of related projects simultaneously. There is no view of the repository where Project A is at Commit #1 but Project B is at Commit #2.

 - `Big pictures`: With everything in one place there is no need to copy code between repositories or to look for infrastructure as code files and documentation.

- `Good practice`: A monorepo requires teams to work with each other. By merging code only with a MR, teams review each other’s code which breaks silos and improves code quality.

 - `Tooling required`: for handling builds with shared libraries, CI-CD and Coverage Page.


# Note

This project drew significant inspiration from [dermidgen](https://github.com/dermidgen/python-monorepo). However, I discovered that the existing methodology is outdated and doesn't support the use of Poetry within Docker, which is a major let down in the Python ecosystem. Here are the improvements I plan to implement compared to the original repository:

- Poetry playwell with docker container.
- Automated formatting and linting for the Python project.
- Docker-based CI/CD pipeline that allows sharing stages between libraries.
- Test and coverage page for whole monorepo including all subprojects.

## Tooling

* [Python3](https://docs.python.org/3/whatsnew/3.8.html) ^3.8: (3.8.16 preferred)

* [Poetry](https://python-poetry.org/) ^1.5: (1.5.1 preferred)

* Bash script for CI/CD builds, most conventions was inherited from [author of FastAPI](https://github.com/tiangolo/full-stack-fastapi-postgresql).

* Docker for containers.

This example demonstrates a local development approach that allows quick access to changes in shared libraries during the development and testing of individual services.

The tooling used enables seamless integration with CI/CD workflows, ensuring that any changes to shared libraries lead to automatic rebuilding and integration testing of dependent services without any delays. The key component contributing to this functionality is Poetry management.

Furthermore, the entire toolset works harmoniously even within a Docker container, making it well-suited for containerized environments.


# General installation and working guide
**Note: poetry work best with fresh conda environment, please create new env for this project**

To install the monorepo system, please read and follow these steps:

1. Go to your project that you're working on, install environment and provide variable env if required

```bash
cd your/project/folder

pip install poetry
poetry install --with dev,lint,test # If you want to package the code, poetry install is enough
```

2. Before create MR, format code and check lint with these steps

```bash
cd your/project/folder

bash scripts/format.sh # Auto format code
bash scripts/lint.sh # Lint check
```

3. Run test in local by simple command

```bash
cd your/project/folder

bash scripts/test.sh
```

