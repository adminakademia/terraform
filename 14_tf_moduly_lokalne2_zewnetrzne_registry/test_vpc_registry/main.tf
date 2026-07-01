  module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~> 5.0"

    name = "kurs-vpc-z-registry"
    cidr = "10.140.0.0/16"

    azs            = ["eu-north-1a", "eu-north-1b"]
    public_subnets = ["10.140.1.0/24", "10.140.2.0/24"]

    enable_nat_gateway   = false   # NAT Gateway KOSZTUJE - wylaczamy go na potrzeby nauki
    enable_dns_hostnames = true

    tags = {
      Project = "kurs-terraform"
      Lekcja  = "14"
    }
  }

  output "vpc_id" {
    value = module.vpc.vpc_id
  }

  output "public_subnets" {
    value = module.vpc.public_subnets
  }