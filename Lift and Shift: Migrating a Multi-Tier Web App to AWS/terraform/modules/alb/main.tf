module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = var.alb_name
  vpc_id  = var.alb_vpc_id
  subnets = var.alb_subnets

  # Security Group
  security_groups = var.alb_security_groups

  listeners = var.alb_listeners

  target_groups = var.target_groups

  enable_deletion_protection = false

  create_security_group = false

  tags = var.tags
}