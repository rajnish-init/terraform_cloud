variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "eu-central-1"
}

variable "environment" {
  description = "Deployment environment (e.g. staging, production)"
  type        = string
  default     = "test-01"
}

variable "project" {
  description = "Project name used for tagging and identification"
  type        = string
  default     = "Terraform Cloud"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
  default     = "tfc-test-bucket"
}
