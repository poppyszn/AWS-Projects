output "arn" {
  value = module.ec2_instance.arn
  description = "Ec2 Instance Amazon Resource Number"
}

output "public_ip" {
  value = module.ec2_instance.public_ip
  description = "Ec2 Instance public IP address"
}

output "private_ip" {
  value = module.ec2_instance.private_ip
  description = "Ec2 Instance private IP address"
}

output "id" {
  value = module.ec2_instance.id
  description = "Ec2 Instance id"
}