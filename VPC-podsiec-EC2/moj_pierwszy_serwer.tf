# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}


resource "aws_vpc" "MojeVPC" {
  cidr_block       = "10.120.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Moje_VPC"
  }
}

resource "aws_subnet" "podsiec1" {
  vpc_id     = aws_vpc.MojeVPC.id
  cidr_block = "10.120.1.0/24"

  tags = {
    Name = "podsiec1"
  }
}

resource "aws_network_interface" "int1-podsiec1" {
  subnet_id   = aws_subnet.podsiec1.id
  private_ips = ["10.120.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "moj_pierwszy_srv_terrafom" {
  ami           = "ami-0e63a5a9c1c7e5563" 
  instance_type = "t3.micro"

  primary_network_interface {
    network_interface_id = aws_network_interface.int1-podsiec1.id
  }

  tags = {
    Name = "moj_pierwszy_srv_terrafom"
  }
}

