aws_region        = "eu-north-1"
availability_zone = "eu-north-1a"

project_name = "kurs-terraform"
environment  = "dev"

vpc_cidr    = "10.120.0.0/16"
subnet_cidr = "10.120.1.0/24"

ssh_cidr_blocks = ["0.0.0.0/0"]

instance_type = "t3.micro"