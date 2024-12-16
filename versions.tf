terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.80.0"
      configuration_aliases = [aws.backend]
    }
  }

  required_version = ">= 1.10.1"
}

