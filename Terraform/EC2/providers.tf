# ============================================================================
# EC2 Module - Provider Configuration
# ============================================================================

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.32.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
