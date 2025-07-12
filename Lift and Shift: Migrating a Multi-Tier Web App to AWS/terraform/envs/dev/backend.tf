#terraform {
#  backend "s3" {
#    bucket         = "my-tf-state-bucket"
#    key            = "dev/terraform.tfstate"
#    region         = var.region
#    dynamodb_table = var.dynamodb_table
#  }
#}

# This would be useful if i were in a dev environment and needed a central source of truth, but since its a personal project, I won't be using this.