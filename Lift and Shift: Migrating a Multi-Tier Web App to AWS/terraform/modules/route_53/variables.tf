variable "route_53_zones" {
  description = "Map of Route53 zones to create"
  type = map(object({
    comment = optional(string)
    vpc = optional(list(object({
      vpc_id     = string
    })))
    tags = optional(map(string))
  }))
  default = {}
}

variable "route_53_records" {
  description = "List of Route53 records to create"
  type = list(object({
    name    = string
    type    = string
    ttl     = optional(number)
    records = optional(list(string))
  }))
  default = []
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}
