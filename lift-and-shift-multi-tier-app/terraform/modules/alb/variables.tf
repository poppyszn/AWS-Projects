variable "alb_name" {
  description = "The name of the ALB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen"
  type        = string
}

variable "alb_vpc_id" {
  description = "Identifier of the VPC where the ALB and security group will be created"
  type        = string
}

variable "alb_subnets" {
  description = "A list of subnet IDs to attach to the ALB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource"
  type        = list(string)
}

variable "alb_security_groups" {
  description = "A list of security group IDs to assign to the ALB"
  type        = list(string)
}

variable "alb_listeners" {
  description = "Map of listener configurations to create"
  type        = any
}

variable "target_groups" {
  description = "Map of target group configurations to create"
  type        = any
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

