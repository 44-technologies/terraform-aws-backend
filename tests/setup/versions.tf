terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.33.0"
    }
  }

  required_version = ">= 1.14.5"
}
