output "private_key" {
  value     = module.create_key_pair.private_key
  sensitive = true
}

output "public_key" {
  value = module.create_key_pair.public_key
}

output "tomcat_instance_public_ip" {
  value       = module.tomcat_instance.public_ip
  description = "Ec2 Instance public IP address for tomcat instance"
}

output "tomcat_instance_private_ip" {
  value       = module.tomcat_instance.private_ip
  description = "Ec2 Instance private IP address for tomcat instance"
}

output "mysql_instance_public_ip" {
  value       = module.mysql_instance.public_ip
  description = "Ec2 Instance public IP address for mysql instance"
}

output "mysql_instance_private_ip" {
  value       = module.mysql_instance.private_ip
  description = "Ec2 Instance private IP address for mysql instance"
}

output "rabbitmq_instance_public_ip" {
  value       = module.rabbitmq_instance.public_ip
  description = "Ec2 Instance public IP address for rabbitmq instance"
}

output "rabbitmq_instance_private_ip" {
  value       = module.rabbitmq_instance.private_ip
  description = "Ec2 Instance private IP address for rabbitmq instance"
}

output "memcache_instance_public_ip" {
  value       = module.memcache_instance.public_ip
  description = "Ec2 Instance public IP address for memcache instance"
}

output "memcache_instance_private_ip" {
  value       = module.memcache_instance.private_ip
  description = "Ec2 Instance private IP address for memcache instance"
}

output "s3_bucket_name" {
  value       = module.s3_bucket.s3_bucket_name
  description = "S3 bucket name"
}