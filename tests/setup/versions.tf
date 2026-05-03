terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.43.0"
    }
  }

  required_version = ">= 1.15.1"
}

