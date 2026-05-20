# cookiecutter-terragrunt-project

[![CI](https://github.com/goabonga/cookiecutter-terragrunt-project/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/goabonga/cookiecutter-terragrunt-project/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/goabonga/cookiecutter-terragrunt-project/blob/main/LICENSE)
[![Python](https://img.shields.io/badge/python-3.12%2B-blue.svg)](https://www.python.org/downloads/)
[![uv](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/uv/main/assets/badge/v0.json)](https://github.com/astral-sh/uv)

A [Cookiecutter](https://cookiecutter.readthedocs.io/) template to scaffold
scalable, multi-environment [Terragrunt](https://terragrunt.gruntwork.io)
infrastructure projects: a DRY root configuration (providers, GCS remote
state, version pin), a per-environment `config.<env>.yaml`, and a set of
shell helpers wrapping the Terragrunt CLI.

## Features

- **Multi-environment** — switch between `dev` / `staging` / `prod` with a
  per-environment YAML config.
- **DRY** — one root `terragrunt.hcl` every module inherits via
  `find_in_parent_folders()`.
- **Batteries included** — `.bashrc` helpers (`switch_env`, `plan`,
  `apply`, `destroy`, …) wrapping the modern Terragrunt CLI.
- **Pairs with** [terragrunt-generator](https://github.com/goabonga/terragrunt-generator)
  to populate the scaffold with per-module `terragrunt.hcl` files.

## Requirements

- Python 3.12+
- [Terraform](https://www.terraform.io) / [OpenTofu](https://opentofu.org)
  and [Terragrunt](https://terragrunt.gruntwork.io) (>= v0.73, new CLI)

## Usage

Generate a project straight from GitHub (no install needed):

```bash
uvx cookiecutter gh:goabonga/cookiecutter-terragrunt-project
# or: cookiecutter gh:goabonga/cookiecutter-terragrunt-project
```

Or install the published template from PyPI and bake the bundled copy:

```bash
pip install cookiecutter-terragrunt-project
cookiecutter "$(python -c 'import cookiecutter_terragrunt_project as p; print(p.__path__[0])')"
```

Answer the prompts (`project_name`, `default_environment`,
`remote_state_bucket_name`, …) and you get:

```
<project_slug>/
├── .bashrc                 # terragrunt helpers (switch_env, plan, apply, …)
├── config.<env>.yaml       # per-environment values
└── google/
    └── terragrunt.hcl      # root config: providers, GCS backend, versions
```

## Day-2 workflow

```bash
source .bashrc           # adds switch_env / plan / apply / destroy / …
switch_env dev           # sets ENV=dev and the gcloud project
plan  ./google/network   # terragrunt run --all -- plan on a subtree
apply ./google/network/vpc
```

## Development

```bash
git clone https://github.com/goabonga/cookiecutter-terragrunt-project.git
cd cookiecutter-terragrunt-project
uv sync
uv run pytest          # bake smoke tests
uvx cookiecutter .     # generate a project from the working copy
```

See [CONTRIBUTING.md](CONTRIBUTING.md) for the workflow, the commit-message
convention and the release process. By participating you agree to the
[Code of Conduct](CODE_OF_CONDUCT.md). Security issues: see
[SECURITY.md](SECURITY.md).

## License

Distributed under the [MIT License](LICENSE).
