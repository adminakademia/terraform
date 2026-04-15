# Serwer EC2
resource "aws_instance" "lekcja5_eu-central-1_ec2_srv" {
  provider                    = aws.eu-central-1
  ami                         = var.regional_amis["eu-central-1"]
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.lekcja5_eu-central-1_subnet.id
  vpc_security_group_ids      = [aws_security_group.lekcja5_eu-central-1_ssh_security_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jaroslaw_aws_ec2.key_name

  tags = {
    Name = "lekcja5_eu-central-1-ec2-srv"
  }
}

# VPC
resource "aws_vpc" "lekcja5_eu-central-1_vpc" {
  provider             = aws.eu-central-1
  cidr_block           = var.network_config["eu-central-1"].vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lekcja5_eu-central-1-ec2-srv"
  }
}

# Subnet
resource "aws_subnet" "lekcja5_eu-central-1_subnet" {
  provider          = aws.eu-central-1
  vpc_id            = aws_vpc.lekcja5_eu-central-1_vpc.id
  cidr_block        = var.network_config["eu-central-1"].subnet_cidr
  availability_zone = var.network_config["eu-central-1"].availability_zone

  tags = {
    Name = "lekcja5_eu-central-1-ec2-srv"
  }
}

# Security Group
resource "aws_security_group" "lekcja5_eu-central-1_ssh_security_group" {
  provider    = aws.eu-central-1
  name        = "ssh_access"
  description = "Zezwol na ruch wejsciowy SSH i WWW"
  vpc_id      = aws_vpc.lekcja5_eu-central-1_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Tworzenie bramy internetowej
resource "aws_internet_gateway" "lekcja5_eu-central-1_igw" {
  provider = aws.eu-central-1
  vpc_id   = aws_vpc.lekcja5_eu-central-1_vpc.id

  tags = {
    Name = "lekcja5_eu-central-1-ec2-srv"
  }
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "lekcja5_eu-central-1_route_table" {
  provider = aws.eu-central-1
  vpc_id   = aws_vpc.lekcja5_eu-central-1_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lekcja5_eu-central-1_igw.id
  }

  tags = {
    Name = "lekcja5_eu-central-1-ec2-srv"
  }
}

# Przypisanie trasy do podsieci
resource "aws_route_table_association" "lekcja5_eu-central-1_rta" {
  provider       = aws.eu-central-1
  subnet_id      = aws_subnet.lekcja5_eu-central-1_subnet.id
  route_table_id = aws_route_table.lekcja5_eu-central-1_route_table.id
}