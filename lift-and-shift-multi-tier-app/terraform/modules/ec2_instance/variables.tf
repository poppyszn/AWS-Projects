variable "ec2_instance_name" {
  type = string
  description = "Name of ec2 instance"
}

variable "ec2_instance_ami" {
  type = string
  description = "Image/OS for ec2 instance"
}

variable "ec2_instance_instance_type" {
  type = string
  description = "Ec2 instance type"
  default = "t2.micro"
}

variable "ec2_instance_key_name" {
  type = string
  description = "Ec2 instance key pair name"
}

variable "ec2_instance_monitoring" {
  type = bool
  description = "Enable monitoring for ec2 instance"
  default = false
}

variable "ec2_instance_vpc_security_group_ids" {
  type = list(string)
  description = "Ec2 instance security group id"
  default = []
}

variable "ec2_instance_user_data" {
  type = string
  description = "Start up script for instance"
  default = ""
}

variable "ec2_instance_volume_size" {
  type = number
  description = "Ec2 instance roor volume size in GB"
  default = 8
}

variable "ec2_instance_volume_type" {
  type = string
  description = "Ec2 instance volume type"
  default = "gp3"
}

variable "ec2_instance_volume_delete_on_termination" {
  type = bool
  description = "Delete instance volume on termination"
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ec2_instance_subnet_id" {
  type  = string
  description = "Subnet ID for EC2 Instance"
}

variable "ec2_instance_create_security_group" {
  type  = bool
  description = "Create a security group with the instance"
  default = true
}

variable "create_iam_instance_profile" {
  type  = bool
  description = "Create an iam role with the instance"
  default = false
}

variable "iam_role_description" {
  type  = string
  description = "Description of iam role"
  default = ""
}

variable "iam_role_policies" {
  type    = map(string)
  default = {}
}