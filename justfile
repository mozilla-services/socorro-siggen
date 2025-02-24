@_default:
    just --list

# Build a dev environment
devenv:
    uv sync --extra dev --refresh --upgrade

# Clean development and build artifacts
clean:
    rm -rf .venv uv.lock
    rm -rf build dist siggen.egg-info .tox .pytest-cache
    rm -rf docs/_build/*
    find siggen/ -name __pycache__ | xargs rm -rf
    find siggen/ -name '*.pyc' | xargs rm -rf

# Format files
format: devenv
    uv run tox exec -e py39-lint -- ruff format

# Lint files
lint: devenv
    uv run tox -e py39-lint

# Run tests and linting
test *args: devenv
    uv run tox {{args}}
