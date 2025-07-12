terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "local" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}