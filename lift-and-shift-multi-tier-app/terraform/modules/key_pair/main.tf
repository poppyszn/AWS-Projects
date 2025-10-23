module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  create             = var.key_pair_create
  create_private_key = var.key_pair_create_private_key
  key_name           = var.key_pair_key_name
  public_key         = var.key_pair_public_key
  tags               = var.tags
}