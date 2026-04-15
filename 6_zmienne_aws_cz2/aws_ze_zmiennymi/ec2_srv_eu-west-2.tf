# Serwer EC2
resource "aws_instance" "lekcja5_eu-west-2_ec2_srv" {
  provider                    = aws.eu-west-2
  ami                         = var.regional_amis["eu-west-2"]
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.lekcja5_eu-west-2_subnet.id
  vpc_security_group_ids      = [aws_security_group.lekcja5_eu-west-2_ssh_security_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jaroslaw_aws_ec2.key_name

  tags = {
    Name = "lekcja5_eu-west-2-ec2-srv"
  }
}

# VPC
resource "aws_vpc" "lekcja5_eu-west-2_vpc" {
  provider             = aws.eu-west-2
  cidr_block           = var.network_config["eu-west-2"].vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lekcja5_eu-west-2-ec2-srv"
  }
}

# Subnet
resource "aws_subnet" "lekcja5_eu-west-2_subnet" {
  provider          = aws.eu-west-2
  vpc_id            = aws_vpc.lekcja5_eu-west-2_vpc.id
  cidr_block        = var.network_config["eu-west-2"].subnet_cidr
  availability_zone = var.network_config["eu-west-2"].availability_zone

  tags = {
    Name = "lekcja5_eu-west-2-ec2-srv"
  }
}

# Security Group
resource "aws_security_group" "lekcja5_eu-west-2_ssh_security_group" {
  provider    = aws.eu-west-2
  name        = "ssh_access"
  description = "Zezwol na ruch wejsciowy SSH i WWW"
  vpc_id      = aws_vpc.lekcja5_eu-west-2_vpc.id

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
resource "aws_internet_gateway" "lekcja5_eu-west-2_igw" {
  provider = aws.eu-west-2
  vpc_id   = aws_vpc.lekcja5_eu-west-2_vpc.id

  tags = {
    Name = "lekcja5_eu-west-2-ec2-srv"
  }
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "lekcja5_eu-west-2_route_table" {
  provider = aws.eu-west-2
  vpc_id   = aws_vpc.lekcja5_eu-west-2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lekcja5_eu-west-2_igw.id
  }

  tags = {
    Name = "lekcja5_eu-west-2-ec2-srv"
  }
}

# Przypisanie trasy do podsieci
resource "aws_route_table_association" "lekcja5_eu-west-2_rta" {
  provider       = aws.eu-west-2
  subnet_id      = aws_subnet.lekcja5_eu-west-2_subnet.id
  route_table_id = aws_route_table.lekcja5_eu-west-2_route_table.id
}