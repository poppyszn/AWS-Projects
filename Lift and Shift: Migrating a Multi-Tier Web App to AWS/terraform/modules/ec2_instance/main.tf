module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_instance_name

  ami = var.ec2_instance_ami
  instance_type = var.ec2_instance_instance_type
  key_name      = var.ec2_instance_key_name
  monitoring    = var.ec2_instance_monitoring
  subnet_id = var.ec2_instance_subnet_id
  vpc_security_group_ids = var.ec2_instance_vpc_security_group_ids
  create_security_group = var.ec2_instance_create_security_group
  user_data = var.ec2_instance_user_data

  root_block_device = {
    volume_size = var.ec2_instance_volume_size  # Size in GB
    volume_type = var.ec2_instance_volume_type
    delete_on_termination = var.ec2_instance_volume_delete_on_termination
  }

  create_iam_instance_profile = var.create_iam_instance_profile
  iam_role_description        = var.iam_role_description
  iam_role_policies = var.iam_role_policies

  tags = var.tags
}