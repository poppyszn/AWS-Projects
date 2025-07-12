module "zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"

  zones = var.route_53_zones
  tags = var.tags
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = "liftandshiftzone"
  zone_id   = module.zones.route53_zone_zone_id[keys(var.route_53_zones)[0]]

  records = var.route_53_records

  depends_on = [module.zones]
}