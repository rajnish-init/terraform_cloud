terraform {
  required_version = ">= 1.6.0"

  cloud {
    organization = "TFC_cloud_demo"

    workspaces {
      name = "terraform_cloud"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
