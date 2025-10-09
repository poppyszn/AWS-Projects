resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = aws_route53_zone.primary.name
  type    = "A"

  alias {
    name                   = var.domain-bucket-website-endpoint
    zone_id                = var.domain-bucket-hosted-zone-id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.sub-domain-bucket-website-endpoint
    zone_id                = var.sub-domain-bucket-hosted-zone-id
    evaluate_target_health = false
  }
}