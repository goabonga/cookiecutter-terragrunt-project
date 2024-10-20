# The 'locals' block defines local variables used within the Terraform configuration.
locals {
  # Retrieves the environment variable 'ENV' or defaults to 'dev'.
  environment = get_env("ENV", "{{cookiecutter.default_environment}}")

  # Merges configuration from YAML files based on the environment.
  config = merge(
    yamldecode(file(find_in_parent_folders(format("config.%s.yaml", local.environment)))),
  )
}

# Generates provider configurations.
generate "provider" {
  path      = "generated_provider.tf" # Specifies the file path for generated provider configurations.
  if_exists = "overwrite_terragrunt"  # Defines the behavior if the file already exists.

  # Contents of the generated provider configurations.
  contents = <<EOF
provider "google" {
  # Google provider configuration block
}

provider "google-beta" {
  # Google Beta provider configuration block
}
EOF
}

# Configures remote state settings for managing Terraform state.
remote_state {
  backend = "gcs" # Specifies the backend for remote state management.
  config = {
    bucket = "${local.config.remote_state.bucket}"
    prefix = "${format("%s/%s", local.environment, path_relative_to_include())}"
  }

  # Generates remote state backend configurations.
  generate = {
    path      = "generated_backend.tf" # Specifies the file path for generated backend configurations.
    if_exists = "overwrite_terragrunt" # Defines the behavior if the file already exists.
  }
}

# Generates Terraform version configurations.
generate "versions" {
  path      = "generated_versions.tf" # Specifies the file path for generated version configurations.
  if_exists = "overwrite_terragrunt"  # Defines the behavior if the file already exists.

  # Contents of the generated version configurations.
  contents = <<EOF
terraform {
  required_version = ">= 1.4.6"   # Sets the minimum required Terraform version.
}
EOF
}
