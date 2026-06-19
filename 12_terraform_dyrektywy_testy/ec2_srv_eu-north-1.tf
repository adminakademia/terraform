# Serwer EC2
resource "aws_instance" "lekcja5_ec2_srv" {
  count                       = terraform.workspace == "prod" ? 2 : 1
  ami                         = local.regional_amis["eu-north-1"]
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.lekcja5_subnet.id
  vpc_security_group_ids      = [aws_security_group.lekcja5_ssh_security_group.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.jaroslaw_aws_ec2.key_name
  depends_on                  = [aws_internet_gateway.lekcja5_igw]

  timeouts {
    create = "15m"
    update = "10m"
    delete = "20m"
  }

  # Konfiguracja startowa generowana z szablonu (zamiast osobnych plikow YAML)
  user_data = templatefile("${path.module}/templates/cloud-init.tftpl", {
    hostname    = "${local.name_prefix}-sztokholm-${count.index}"
    environment = terraform.workspace
    packages    = local.cloud_init_packages
  })
  user_data_replace_on_change = true

  lifecycle {
    # PRZED utworzeniem: sprawdz czy typ instancji jest na liscie dozwolonych przez budzet projektu
    precondition {
      condition     = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Niedozwolony typ instancji: ${var.instance_type}. Budzet projektu pozwala wylacznie na: ${join(", ", local.allowed_instance_types)}."
    }

    # PO utworzeniu: sprawdz czy AWS przydzielil publiczny IP
    postcondition {
      condition     = self.public_ip != ""
      error_message = "Instancja zostala utworzona BEZ publicznego IP - nie bedzie mozna sie zalogowac przez SSH."
    }
  }


  tags = merge(local.common_tags, {
    Name        = "${local.name_prefix}-ec2-srv-sztokholm-${count.index}"
    Role        = "WebServer"
    Environment = terraform.workspace
    Tier        = terraform.workspace == "prod" ? "production" : "non-production"
  })


}


# VPC
resource "aws_vpc" "lekcja5_vpc" {
  cidr_block           = var.network_config["eu-north-1"].vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc-sztokholm"
  })
}

# Subnet
resource "aws_subnet" "lekcja5_subnet" {
  vpc_id            = aws_vpc.lekcja5_vpc.id
  cidr_block        = var.network_config["eu-north-1"].subnet_cidr
  availability_zone = var.network_config["eu-north-1"].availability_zone

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-subnet-sztokholm"
  })
}

# Security Group
resource "aws_security_group" "lekcja5_ssh_security_group" {
  name        = "ssh_access"
  description = "Zezwol na ruch wejsciowy SSH i WWW"
  vpc_id      = aws_vpc.lekcja5_vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-sg-sztokholm"
  })

}

# Tworzenie bramy internetowej
resource "aws_internet_gateway" "lekcja5_igw" {
  vpc_id = aws_vpc.lekcja5_vpc.id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-igw-sztokholm"
  })
}

# Tworzenie trasy dla ruchu internetowego
resource "aws_route_table" "lekcja5_route_table" {
  vpc_id = aws_vpc.lekcja5_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lekcja5_igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rt-sztokholm"
  })
}

# Przypisanie trasy do podsieci
resource "aws_route_table_association" "lekcja5_rta" {
  subnet_id      = aws_subnet.lekcja5_subnet.id
  route_table_id = aws_route_table.lekcja5_route_table.id
}