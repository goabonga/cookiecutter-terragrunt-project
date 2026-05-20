# {{ cookiecutter.project_name }}

Multi-environment [Terragrunt](https://terragrunt.gruntwork.io) infrastructure,
scaffolded with
[cookiecutter-terragrunt-project](https://github.com/goabonga/cookiecutter-terragrunt-project).

## Layout

```
.
├── .bashrc                 # helper commands wrapping the Terragrunt CLI
├── config.{{ cookiecutter.default_environment }}.yaml   # per-environment values
└── google/
    └── terragrunt.hcl      # root config: providers, GCS backend, versions
```

## Requirements

- [Terraform](https://www.terraform.io) / [OpenTofu](https://opentofu.org)
- [Terragrunt](https://terragrunt.gruntwork.io) (>= v0.73, new CLI)
- [`gcloud`](https://cloud.google.com/sdk/docs/install), authenticated

## Helper commands (`.bashrc`)

The `.bashrc` defines small functions that wrap Terragrunt with the right
flags and an environment switch. Load them into your shell first:

```bash
source .bashrc
```

Then pick an environment (sets `ENV` and the active gcloud project from
`config.<env>.yaml`):

```bash
switch_env {{ cookiecutter.default_environment }}
```

All commands take a path to a unit or a subtree:

| Command | What it runs |
| --- | --- |
| `init ./google/network/vpc` | `terragrunt run --all -- init -reconfigure` |
| `plan ./google/network` | `terragrunt run --all -- plan` over the subtree |
| `apply ./google/network/vpc` | `terragrunt run --all -- apply` (auto-approved) |
| `destroy ./google/network/vpc` | `terragrunt run --all -- destroy` |
| `output ./google/network/vpc` | `terragrunt run --all -- output` |
| `refresh ./google/network` | `terragrunt run --all -- refresh` |
| `providers ./google/network/vpc` | `terragrunt run -- providers` (single unit) |
| `state ./google/network/vpc list` | `terragrunt run -- state ...` (single unit) |
| `import ./google/... <addr> <id>` | `terragrunt run -- import ...` (single unit) |
| `show ./google/network/vpc` | `terragrunt run -- show` (single unit) |
| `clean` | remove `.terragrunt-cache`, lockfiles and generated `*.tf` |

Typical loop:

```bash
source .bashrc
switch_env {{ cookiecutter.default_environment }}
plan  ./google/network
apply ./google/network/vpc
```

Add another environment by creating `config.<env>.yaml` and running
`switch_env <env>` - no changes to the modules are needed.

## Populating modules

Generate per-module `terragrunt.hcl` files (and their input skeletons in
`config.<env>.yaml`) with
[terragrunt-generator](https://github.com/goabonga/terragrunt-generator).
