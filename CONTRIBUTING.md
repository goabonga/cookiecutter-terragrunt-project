# Contributing to cookiecutter-terragrunt-project

Thanks for taking the time to contribute. This document is the short
version of how to propose a change and what the project expects in return.

## Code of Conduct

Participation in this project is governed by the
[Code of Conduct](CODE_OF_CONDUCT.md). By contributing you agree to abide
by its terms.

## Repository layout

```
.
├── cookiecutter.json                 # template prompts / defaults
├── {{cookiecutter.project_slug}}/    # the templated project tree
├── tests/                            # bake smoke tests (pytest-cookies)
├── scripts/                          # SPDX header helper
├── pyproject.toml                    # uv project + hatchling build
└── multicz.toml                      # Conventional Commits releasing
```

The Cookiecutter template itself lives under
`{{cookiecutter.project_slug}}/`. Files there are rendered into the
user's generated project, so they intentionally do **not** carry this
repository's SPDX license header.

## Development setup

```bash
git clone https://github.com/goabonga/cookiecutter-terragrunt-project.git
cd cookiecutter-terragrunt-project
uv sync

# Install the pre-commit + commit-msg hooks.
uv run pre-commit install
```

## Running the tests

The tests bake the template with [pytest-cookies](https://github.com/hackebrot/pytest-cookies)
and assert the generated structure:

```bash
uv run pytest
```

Generate a real project from your working copy to eyeball the output:

```bash
uvx cookiecutter .
```

## Lint and headers

```bash
uv run ruff check .
uv run ruff format --check .
python scripts/add_license_header.py --path . --types py,yml,toml --check
```

The template tree is excluded from both ruff and the SPDX check.

## Packaging

The template is force-included into a hatchling-built wheel so it can be
published to PyPI while still working via `cookiecutter gh:...`. Verify a
build before changing packaging:

```bash
uv build
# inspect dist/*.whl - the {{ }} filenames must be preserved
```

## Commit messages

Commit messages MUST follow
[Conventional Commits](https://www.conventionalcommits.org/). They drive
the version bump and CHANGELOG computed by
[multicz](https://github.com/goabonga/multicz).

| Type | Effect on version | Use it for |
| --- | --- | --- |
| `feat` | minor | new template capability |
| `fix` | patch | bug fix in the template or tooling |
| `refactor`, `docs`, `test`, `chore`, `ci`, `build`, `style` | none | maintenance |
| `feat!` / `BREAKING CHANGE:` | major | incompatible change to the generated output |

Only changes under the tracked paths (`cookiecutter.json`, the template
tree, `pyproject.toml`) trigger a release. Do not append `Co-Authored-By`
trailers.

## Releasing

Releases are automated: on every push to `main`, the workflow runs
`multicz bump --commit --tag --push` and publishes the packaged template
to PyPI. Maintainers do not bump versions or edit the changelog by hand.

## Reporting bugs and asking for features

Please open a GitHub issue. For security-sensitive reports, follow
[SECURITY.md](SECURITY.md) instead of the public tracker.
