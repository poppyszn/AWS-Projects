terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "s3-static-website" {
  source = "./modules/s3-static-website"

  domain_name = "example.com"
  index_source = "./site/index.html"
  error_source = "./site/404.html"
}

output "s3-endpoint" {
  value = module.s3-static-website.s3-endpoint
}

# module "storage" {
#   source = "./modules/storage"

#   domain_name = var.domain_name
#   index_source = "./site/index.html"
#   error_source = "./site/404.html"
# }

# module "networking" {
#   source = "./modules/networking"

#   domain_name = var.domain_name
#   domain-bucket-hosted-zone-id = module.storage.domain-bucket-hosted-zone-id
#   domain-bucket-website-endpoint = module.storage.domain-bucket-website-endpoint
#   sub-domain-bucket-hosted-zone-id = module.storage.sub-domain-bucket-hosted-zone-id
#   sub-domain-bucket-website-endpoint = module.storage.sub-domain-bucket-website-endpoint
# }

# module "iam" {
#   source = "./modules/iam"

#   domain-bucket-name = module.storage.domain-bucket-name
#   domain-bucket-id = module.storage.domain-bucket-id
#   domain-bucket-arn = module.storage.domain-bucket-arn
#   logging-bucket-name = module.storage.logging-bucket-name
#   logging-bucket-arn = module.storage.logging-bucket-arn
# }