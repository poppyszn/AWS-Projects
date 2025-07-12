variable "acm_domain_name" {
  type = string
  description = "A domain name for which the certificate should be issued"
}

variable "acm_zone_id" {
  type = string
  description = "The ID of the hosted zone to contain this record. Required when validating via Route53"
}

variable "subject_alternative_names" {
  type = list(string)
  description = "A list of domains that should be SANs in the issued certificate"
}

variable "tags" {
  type = map(string)
  description = "A mapping of tags to assign to the resource"
}