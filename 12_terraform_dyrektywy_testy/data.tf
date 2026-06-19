# Najnowsze AMI Ubuntu 24.04 LTS (Noble) dla regionu Sztokholm (domyślny provider)
data "aws_ami" "ubuntu_najnowszy" {
  most_recent = true
  owners      = [local.ubuntu_owner_id] # Oficjalne konto Canonical (Ubuntu) w AWS

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# To samo dla Frankfurtu
data "aws_ami" "ubuntu_najnowszy_eu-central-1" {
  provider    = aws.eu-central-1
  most_recent = true
  owners      = [local.ubuntu_owner_id]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# To samo dla Londynu
data "aws_ami" "ubuntu_najnowszy_eu-west-2" {
  provider    = aws.eu-west-2
  most_recent = true
  owners      = [local.ubuntu_owner_id]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}



# Lista stref dostepnosci dla regionu Sztokholm
data "aws_availability_zones" "sztokholm" {
  state = "available"
}

# Informacje o aktualnym koncie AWS (account_id, user_id, arn)
data "aws_caller_identity" "current" {}

# Informacje o aktualnym regionie
data "aws_region" "current" {}

