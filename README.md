# Cookiecutter Mgczacki PyPackage

Cookiecutter template for a cutting-edge Python package: uv, ruff, mypy, GitHub Actions and more!

## Features

* [X] Lightweight starter
* [X] [uv](https://docs.astral.sh/uv/) package management
* [X] Linting and formatting with [`ruff`](https://github.com/charliermarsh/ruff)
* [X] Type checking with [`mypy`](https://github.com/python/mypy)
* [X] Unit tests with [`pytest`](https://github.com/pytest-dev/pytest) with optional asyncio setup.
* [X] Documentation with [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) and docstring reference support with [mkdocstrings](https://mkdocstrings.github.io/).
* [X] Ready-to-use [GitHub Actions](https://help.github.com/en/actions/automating-your-workflow-with-github-actions) pipelines

## Quickstart

Generate the project:

```bash
cookiecutter https://github.com/codingmaster8/cookiecutter-template
```

The generator will automatically set up a `.venv` and install dependencies using `uv`.

Then, for the GitHub Actions pipelines to work correctly, you should:

* Enable the GitHub repository in Codecov.
* Set `CODECOV_TOKEN` in your GitHub repository secrets. You can find in the Codecov settings of the corresponding project.
* Enable GitHub Pages using the GitHub Actions source.
* Configure the [Trusted Publisher method on PyPI](https://docs.pypi.org/trusted-publishers/creating-a-project-through-oidc/): it's a modern and secure method to push your package to PyPI.

### With cruft

[cruft](https://github.com/cruft/cruft) is a layer above Cookiecutter allowing you to update your project from the template after it has been generated.

```bash
cruft create https://github.com/codingmaster8/cookiecutter-template
```

## License

This project is licensed under the terms of the MIT license.
Created based on https://github.com/frankie567/cookiecutter-hipster-pypackage
