module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  ingress_rules       = var.ingress_rules
  ingress_cidr_blocks      = var.ingress_cidr_blocks
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks

  # Computed inbound from other SGs
  computed_ingress_with_source_security_group_id = var.computed_ingress_with_source_security_group_id
  number_of_computed_ingress_with_source_security_group_id = length(var.computed_ingress_with_source_security_group_id)

  # Egress (optional overrides)
  egress_rules       = var.egress_rules
  egress_cidr_blocks = var.egress_cidr_blocks

  tags = var.tags
}