# terraform-cloud

> AWS infrastructure managed with **Terraform Cloud** and automated via **GitHub Actions**.

## Overview

This project provisions AWS resources using Terraform, with remote state stored and executed in [Terraform Cloud](https://app.terraform.io). A GitHub Actions workflow automatically plans on pull requests and applies on merge to `main`.

## Architecture

```
terraform_cloud/
├── terraform.tf             # Terraform Cloud backend + required providers
├── provider.tf              # AWS provider configuration
├── variables.tf             # All input variable declarations
├── locals.tf                # Computed locals (common tags)
├── s3.tf                    # S3 bucket resource
├── outputs.tf               # Output values
├── terraform.tfvars.example # Example variable values (safe to commit)
├── modules/                 # Reusable child modules (see modules/README.md)
└── .github/
    └── workflows/
        └── terraform-plan.yml  # CI: plan on PR, apply on merge to main
```

## Prerequisites

| Tool | Version |
|------|---------|
| Terraform | >= 1.6.0 |
| AWS Provider | ~> 6.0 |
| Terraform Cloud account | — |

### Required Secrets (GitHub → Settings → Secrets)

| Secret | Description |
|--------|-------------|
| `TF_API_TOKEN` | Terraform Cloud API token with workspace access |

### Required Terraform Cloud Workspace Variables

| Variable | Type | Description |
|----------|------|-------------|
| `bucket_name` | Terraform | Globally unique S3 bucket name |
| `aws_region` | Terraform | AWS region (default: `eu-central-1`) |
| `environment` | Terraform | Deployment environment (default: `staging`) |
| `project` | Terraform | Project name for tagging (default: `Terraform Cloud`) |
| `AWS_ACCESS_KEY_ID` | Environment | AWS credentials |
| `AWS_SECRET_ACCESS_KEY` | Environment | AWS credentials (sensitive) |

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `aws_region` | `string` | `"eu-central-1"` | AWS region to deploy into |
| `environment` | `string` | `"staging"` | Deployment environment |
| `project` | `string` | `"Terraform Cloud"` | Project name used for tagging |
| `bucket_name` | `string` | — | Globally unique S3 bucket name |

## Outputs

| Name | Description |
|------|-------------|
| `s3_bucket_id` | Name (ID) of the S3 bucket |
| `s3_bucket_arn` | ARN of the S3 bucket |

## Running Locally

> **Note:** Terraform Cloud is the execution backend; local runs require a valid TFC token.

```bash
# Authenticate with Terraform Cloud
terraform login

# Initialise (downloads providers, connects to TFC workspace)
terraform init

# Preview changes
terraform plan

# Apply changes
terraform apply
```

To use local variable values during development, copy the example file:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars — it is gitignored and will never be committed
```

## CI/CD Workflow

| Trigger | Job | Action |
|---------|-----|--------|
| Pull Request → `main` | `terraform-plan` | fmt check, validate, plan, posts results as PR comment |
| Push to `main` | `terraform-apply` | init → `apply -auto-approve` via Terraform Cloud |

## State Management

Remote state is managed by **Terraform Cloud**:
- **Organization:** `TFC_cloud_demo`
- **Workspace:** `terraform_cloud`

No local state files are used or committed.

## Resources Managed

| Resource | Type | Description |
|----------|------|-------------|
| `aws_s3_bucket.example` | `aws_s3_bucket` | General-purpose S3 bucket |
