# Serwer EC2
resource "aws_instance" "lekcja5_ec2_srv" {
  ami                         = "ami-01ef747f983799d6f"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.lekcja5_subnet.id
  vpc_security_group_ids      = [aws_security_group.lekcja5_ssh_security_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jaroslaw_aws_ec2.key_name

  tags = {
    Name = "lekcja5-ec2-srv"
  }
}


# VPC
resource "aws_vpc" "lekcja5_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lekcja5-ec2-srv"
  }
}

# Subnet
resource "aws_subnet" "lekcja5_subnet" {
  vpc_id            = aws_vpc.lekcja5_vpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "lekcja5-ec2-srv"
  }
}

# Security Group
resource "aws_security_group" "lekcja5_ssh_security_group" {
  name        = "ssh_access"
  description = "Zezwol na ruch wejsciowy SSH i WWW"
  vpc_id      = aws_vpc.lekcja5_vpc.id

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
resource "aws_internet_gateway" "lekcja5_igw" {
  vpc_id = aws_vpc.lekcja5_vpc.id

  tags = {
    Name = "lekcja5-ec2-srv"
  }
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "lekcja5_route_table" {
  vpc_id = aws_vpc.lekcja5_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lekcja5_igw.id
  }

  tags = {
    Name = "lekcja5-ec2-srv"
  }
}

# Przypisanie trasy do podsieci
resource "aws_route_table_association" "lekcja5_rta" {
  subnet_id      = aws_subnet.lekcja5_subnet.id
  route_table_id = aws_route_table.lekcja5_route_table.id
}
