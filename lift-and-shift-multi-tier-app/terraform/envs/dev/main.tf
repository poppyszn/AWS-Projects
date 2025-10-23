# Obtain Default VPC ID
data "aws_vpc" "default" {
  default = true
}

# Obtain Default Subnet in VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# Obtain Amazon Linux ami
data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023*x86_64"] # Matches Amazon Linux 2023 for x86_64
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Obtain Ubuntu Linux ami
data "aws_ami" "ubuntu_24" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu*24*amd64*"] # Matches Ubuntu 24.04 Image
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Use a wrapper module for our key-pair
module "create_key_pair" {
  source                      = "../../modules/key_pair"
  key_pair_key_name           = var.key_pair_key_name
  key_pair_create_private_key = var.key_pair_create_private_key
  tags                        = var.tags
}

module "alb_sg" {
  source = "../../modules/security_group"

  security_group_name        = "alb_sg"
  security_group_description = "Security group for ALB for lift and shift"
  vpc_id                     = data.aws_vpc.default.id

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = var.tags
}

module "tomcat_sg" {
  source = "../../modules/security_group"

  security_group_name        = "tomcat_sg"
  security_group_description = "Security group for tomcat servers for lift and shift"
  vpc_id                     = data.aws_vpc.default.id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 8080
      to_port                  = 8080
      protocol                 = "tcp"
      description              = "Apache Tomcat"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]

  tags = var.tags
}

module "backend_sg" {
  source = "../../modules/security_group"

  security_group_name        = "backend_sg"
  security_group_description = "Security group for backend servers for lift and shift"
  vpc_id                     = data.aws_vpc.default.id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "MYSQL"
      source_security_group_id = module.tomcat_sg.security_group_id
    },
    {
      from_port                = 11211
      to_port                  = 11211
      protocol                 = "tcp"
      description              = "Memcached"
      source_security_group_id = module.tomcat_sg.security_group_id
    },
    {
      from_port                = 5672
      to_port                  = 5672
      protocol                 = "tcp"
      description              = "RabbitMQ"
      source_security_group_id = module.tomcat_sg.security_group_id
    }
  ]

  tags = var.tags
}


module "tomcat_instance" {
  source = "../../modules/ec2_instance"

  ec2_instance_name = "tomcat_instance"

  ec2_instance_ami                    = data.aws_ami.ubuntu_24.id
  ec2_instance_instance_type          = "t2.micro"
  ec2_instance_key_name               = module.create_key_pair.key_pair_name
  ec2_instance_subnet_id              = data.aws_subnets.default.ids[0]
  ec2_instance_vpc_security_group_ids = [module.tomcat_sg.security_group_id]
  ec2_instance_create_security_group  = false

  ec2_instance_volume_size = 8

  create_iam_instance_profile = true
  iam_role_description        = "IAM S3 Access role for EC2 instance"
  iam_role_policies = {
    AmazonS3FullAccess = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }

  tags = var.tags
}

module "mysql_instance" {
  source = "../../modules/ec2_instance"

  ec2_instance_name = "mysql_instance"

  ec2_instance_ami                    = data.aws_ami.amazon_linux_2023.id
  ec2_instance_instance_type          = "t2.micro"
  ec2_instance_key_name               = module.create_key_pair.key_pair_name
  ec2_instance_subnet_id              = data.aws_subnets.default.ids[0]
  ec2_instance_vpc_security_group_ids = [module.backend_sg.security_group_id]
  ec2_instance_create_security_group  = false

  ec2_instance_volume_size = 8


  tags = var.tags
}

module "rabbitmq_instance" {
  source = "../../modules/ec2_instance"

  ec2_instance_name = "rabbitmq_instance"

  ec2_instance_ami                    = data.aws_ami.amazon_linux_2023.id
  ec2_instance_instance_type          = "t2.micro"
  ec2_instance_key_name               = module.create_key_pair.key_pair_name
  ec2_instance_subnet_id              = data.aws_subnets.default.ids[0]
  ec2_instance_vpc_security_group_ids = [module.backend_sg.security_group_id]
  ec2_instance_create_security_group  = false

  ec2_instance_volume_size = 8


  tags = var.tags
}

module "memcache_instance" {
  source = "../../modules/ec2_instance"

  ec2_instance_name = "memcache_instance"

  ec2_instance_ami                    = data.aws_ami.amazon_linux_2023.id
  ec2_instance_instance_type          = "t2.micro"
  ec2_instance_key_name               = module.create_key_pair.key_pair_name
  ec2_instance_subnet_id              = data.aws_subnets.default.ids[0]
  ec2_instance_vpc_security_group_ids = [module.backend_sg.security_group_id]
  ec2_instance_create_security_group  = false

  ec2_instance_volume_size = 8


  tags = var.tags
}

module "route_53_zones" {
  source = "../../modules/route_53"

  route_53_zones = {
    # Public zone for dev-pops.site - NO vpc key means public zone
    "dev-pops.site" = {
      comment = "dev-pops domain for lift and shift project (public zone)"
      vpc     = [] 
      tags = {
        Name = "dev-pops.site-public"
        Type = "public"
      }
    }

    # Private zone for dev-pops.site
    "private-vpc.dev-pops.site" = {
      domain_name = "dev-pops.site"
      comment = "dev-pops domain for lift and shift project (private zone)"
      vpc = [
        {
          vpc_id     = data.aws_vpc.default.id
        }
      ]
      tags = {
        Name = "dev-pops.site-private"
        Type = "private"
      }
    }
  }

  tags = var.tags
}

module "records_public" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name  = "dev-pops.site" 

  records = [
    {
      key   = "alb_apex"
      name  = ""  
      type  = "A"

      alias = {
        name                   = module.alb.alb_dns_name
        zone_id                = module.alb.alb_zone_id   
        evaluate_target_health = true
      }
    }
  ]

  depends_on = [module.route_53_zones]
}

module "records_private" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name    = "private-vpc.dev-pops.site"
  private_zone = true 

  records = [
    {
      zone_key = "private-vpc.dev-pops.site"
      name     = "db01"
      type     = "A"
      ttl      = 300
      records  = [module.mysql_instance.private_ip]
    },
    {
      zone_key = "private-vpc.dev-pops.site"
      name     = "mc01"
      type     = "A"
      ttl      = 300
      records  = [module.memcache_instance.private_ip]
    },
    {
      zone_key = "private-vpc.dev-pops.site"
      name     = "rmq01"
      type     = "A"
      ttl      = 300
      records  = [module.rabbitmq_instance.private_ip]
    }
  ]

  depends_on = [module.route_53_zones]
}


module "acm" {
  source = "../../modules/acm"

  acm_domain_name = "dev-pops.site"
  acm_zone_id     = module.route_53_zones.route53_zone_zone_id["dev-pops.site"]

  subject_alternative_names = [
    "*.dev-pops.site",
    "dev-pops.site",
  ]

  tags = var.tags
}

module "alb" {
  source = "../../modules/alb"

  alb_name    = "lift-shift-alb"
  alb_vpc_id  = data.aws_vpc.default.id
  alb_subnets = data.aws_subnets.default.ids

  # Security Group
  alb_security_groups = [module.alb_sg.security_group_id]

  alb_listeners = {
    # HTTP listener - redirects to HTTPS
    http = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    # HTTPS listener - forwards to target group
    https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
      certificate_arn = module.acm.acm_certificate_arn

      forward = {
        target_group_key = "tomcat_servers"
      }
    }
  }

  target_groups = {
    tomcat_servers = {
      name_prefix      = "tomcat"
      protocol         = "HTTP"
      port             = 8080
      target_type      = "instance"
      target_id   = module.tomcat_instance.id
    }
  }

  tags = var.tags
}

module "s3_bucket" {
  source = "../../modules/s3_bucket"

  s3_bucket_name = var.s3_bucket_name
}

# Save private key to file for Ansible
resource "local_file" "private_key" {
  content         = module.create_key_pair.private_key
  filename        = "${path.module}/../../../ansible/private_key.pem"
  file_permission = "0600"
}

# Generate Ansible inventory
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/../templates/inventory.tftpl", {
    tomcat_ip   = module.tomcat_instance.public_ip
    mysql_ip    = module.mysql_instance.public_ip
    rabbitmq_ip = module.rabbitmq_instance.public_ip
    memcache_ip = module.memcache_instance.public_ip
    private_key = "${path.module}/private_key.pem"
  })
  filename = "${path.module}/../../../ansible/inventory.ini"

  depends_on = [local_file.private_key]
}

