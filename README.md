# Python Monorepo

This is an example of how python structure in monorepo fashion, with the goal of demonstrating:

 - `Scopes`: The folders act as scopes to make sure code artifacts are only visible when they should be. This allows to extract common tasks (e.g. building a C# solution) quickly and maintainers can easier reason about where the error lies.

 - `The One Version Rule (Atomic Commits)`. The principle guarantee that you can commit atomically to both of related projects simultaneously. There is no view of the repository where Project A is at Commit #1 but Project B is at Commit #2.

 - `Big pictures`: With everything in one place there is no need to copy code between repositories or to look for infrastructure as code files and documentation.

- `Good practice`: A monorepo requires teams to work with each other. By merging code only with a MR, teams review each other’s code which breaks silos and improves code quality.

 - `Tooling`: for handling builds with shared libraries, CI-CD and Coverage Page.



## Tooling

* [Python3](https://docs.python.org/3/whatsnew/3.8.html) ^3.8: (3.8.16 preferred)

* [Poetry](https://python-poetry.org/) ^1.5: (1.5.1 preferred)

* Bash script for CI/CD builds, most convention was inherited from [FastAPI author](https://github.com/tiangolo/full-stack-fastapi-postgresql).

* Docker for containers.

This example provides tooling that facilitates a local development approach, enabling immediate availability of changes to shared libraries while running and testing individual services.

This setup also supports CI/CD workflows, ensuring that any modifications to shared libraries trigger the rebuilding and integration testing of dependent services without delay. Poetry plays a significant role in achieving this functionality.

Additionally, all the tooling is playing well with each other even in Docker container.


# General installation and working guide
**Note: poetry work best with fresh conda environment, please create new env for this project**

To install the monorepo system, please read and follow these steps:

1. Go to your project that you're working on, install environment and provide variable env if required

```bash
cd your/project/folder

pip install poetry
poetry install --with lint,test

# If the .env_template is available [Optional]
cp .env_template .env
vim .env
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

pytest
```

# Note

Most of this project was inspire by [dermidgen](https://github.com/dermidgen/python-monorepo) but I found the current methology is old and can not use poetry in Docker is really pain point. Here is the thing that I planning to enhance from original repo:

- Poetry playwell with docker build.
- Format and lint for python project.
- CI-CD in Docker that can share stage between libs.
- Coverage page for whole repo including all subprojects.