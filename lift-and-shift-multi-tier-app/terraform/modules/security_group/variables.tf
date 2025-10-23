variable "security_group_name" {
  type = string
  description = "Name of security group"
}

variable "security_group_description" {
  type = string
  description = "Security group for lift and shift application"
}

variable "vpc_id" {
  type = string
  description = "VPC ID for the security group"
}

variable "ingress_rules" {
  type        = list(string)
  default     = []
  description = "Ingress rules for the security group"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "Ingress CIDR blocks for the security group"
}

variable "ingress_with_cidr_blocks" {
  description = "Custom ingress rules with explicit ports and CIDRs"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = optional(string)
  }))
  default = []
}

variable "computed_ingress_with_source_security_group_id" {
  description = "Ingress rules referencing other SG IDs"
  type = list(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    source_security_group_id = string
    description              = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  type        = list(string)
  default     = ["all-all"]
  description = "Egress rules for the security group"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Egress CIDR blocks for the security group"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for resources"
}