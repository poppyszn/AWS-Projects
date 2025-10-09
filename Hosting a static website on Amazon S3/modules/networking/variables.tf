variable "domain_name" {
  description = "Domain for bucket"
  type = string
}

variable "domain-bucket-website-endpoint" {
  description = "Website endpoint for domain bucket"
  type = string
}

variable "domain-bucket-hosted-zone-id" {
  description = "WebsHosted zone id for domain bucket"
  type = string
}

variable "sub-domain-bucket-website-endpoint" {
  description = "Website endpoint for sub-domain bucket"
  type = string
}

variable "sub-domain-bucket-hosted-zone-id" {
  description = "WebsHosted zone id for sub-domain bucket"
  type = string
}