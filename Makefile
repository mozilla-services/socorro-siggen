DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Available rules:"
	@echo ""
	@fgrep -h "##" Makefile | fgrep -v fgrep | sed 's/\(.*\):.*##/\1:/'

.PHONY: clean
clean:  ## Clean build artifacts
	rm -rf build dist siggen.egg-info .tox .pytest-cache
	rm -rf docs/_build/*
	find siggen/ tests/ -name __pycache__ | xargs rm -rf
	find siggen/ tests/ -name '*.pyc' | xargs rm -rf

.PHONY: format
format:  ## Format Python files
	tox exec -e py39-lint -- ruff format

.PHONY: lint
lint:  ## Lint files
	tox -e py39-lint

.PHONY: test
test:  ## Run tests
	tox
