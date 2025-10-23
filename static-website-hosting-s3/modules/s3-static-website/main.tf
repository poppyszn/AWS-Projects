module "storage" {
  source = "../storage"

  domain_name = var.domain_name
  index_source = var.index_source
  error_source = var.error_source
}

module "networking" {
  source = "../networking"

  domain_name = var.domain_name
  domain-bucket-hosted-zone-id = module.storage.domain-bucket-hosted-zone-id
  domain-bucket-website-endpoint = module.storage.domain-bucket-website-endpoint
  sub-domain-bucket-hosted-zone-id = module.storage.sub-domain-bucket-hosted-zone-id
  sub-domain-bucket-website-endpoint = module.storage.sub-domain-bucket-website-endpoint
}

module "iam" {
  source = "../iam"

  domain-bucket-name = module.storage.domain-bucket-name
  domain-bucket-id = module.storage.domain-bucket-id
  domain-bucket-arn = module.storage.domain-bucket-arn
  logging-bucket-name = module.storage.logging-bucket-name
  logging-bucket-arn = module.storage.logging-bucket-arn
}