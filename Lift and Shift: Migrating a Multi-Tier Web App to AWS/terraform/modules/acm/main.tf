module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = var.acm_domain_name
  zone_id      = var.acm_zone_id 

  validation_method = "DNS"

  subject_alternative_names = var.subject_alternative_names 

  wait_for_validation = false

  tags = var.tags
}