# Najnowsze AMI Ubuntu 24.04 (jak w lekcjach 10/13/14/15):
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

# Kim jestesmy? (znane z lekcji 10 i z bootstrapu w lekcji 15)
data "aws_caller_identity" "current" {}
