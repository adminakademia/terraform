# Odczyt stanu warstwy NETWORK - nasze "okno" na cudzy projekt:
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tfstate-604598162949-eu-north-1" # <- nazwa TWOJEGO kubelka
    key    = "dev/network/terraform.tfstate"   # <- klucz stanu warstwy NETWORK (nie naszej!)
    region = "eu-north-1"
  }
}

# Najnowsze AMI Ubuntu 24.04 (jak w lekcjach 10/13/14):
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # oficjalne konto Canonical (Ubuntu)

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
