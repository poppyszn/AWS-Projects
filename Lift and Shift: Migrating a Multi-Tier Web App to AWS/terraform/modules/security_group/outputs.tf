output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.security_group_id
}

output "security_group_arn" {
  description = "The ARN"
  value       = module.security_group.security_group_arn
}

output "security_group_name" {
  description = "The name"
  value       = module.security_group.security_group_name
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.security_group.security_group_vpc_id
}