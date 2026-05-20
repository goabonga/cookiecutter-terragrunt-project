# SPDX-License-Identifier: MIT
# Copyright (c) 2024-2026 Chris <goabonga@pm.me>

from contextlib import contextmanager

from cookiecutter.utils import rmtree


@contextmanager
def bake_in_temp_dir(cookies, **kwargs):
    """Bake the template and clean up the generated project afterwards."""
    result = cookies.bake(**kwargs)
    try:
        yield result
    finally:
        if result.project_path is not None:
            rmtree(str(result.project_path))


def test_bake_with_defaults(cookies):
    with bake_in_temp_dir(cookies) as result:
        assert result.exit_code == 0
        assert result.exception is None
        assert result.project_path.is_dir()

        # project_name "ACME Infrastructure" -> slug "acme_infrastructure".
        assert result.project_path.name == "acme_infrastructure"

        top_level = {f.name for f in result.project_path.glob("*")}
        assert "README.md" in top_level
        assert "config.dev.yaml" in top_level
        assert ".bashrc" in top_level
        assert (result.project_path / "google" / "terragrunt.hcl").is_file()


def test_bake_with_custom_environment(cookies):
    with bake_in_temp_dir(
        cookies,
        extra_context={"project_name": "My Infra", "default_environment": "prod"},
    ) as result:
        assert result.exit_code == 0
        assert result.project_path.name == "my_infra"
        # The per-environment config filename follows default_environment.
        assert (result.project_path / "config.prod.yaml").is_file()
