# Dev_Build Infrastructure

[![Terraform CI/CD Pipeline](https://github.com/ALwin777-ops/Dev_Build/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/ALwin777-ops/Dev_Build/actions/workflows/terraform-ci.yml)

Automated Terraform project deploying containerized web applications using Docker and GitHub Actions.

## CI/CD Workflow Steps
* **Checkout:** Clones project files onto the runner.
* **Setup:** Installs the Terraform CLI.
* **Format Check:** Verifies code formatting with `terraform fmt -check`.
* **Init:** Initializes providers inside the CI runner.
* **Validate:** Checks syntax accuracy with `terraform validate`.
* **Plan:** Generates an execution plan with `terraform plan`.