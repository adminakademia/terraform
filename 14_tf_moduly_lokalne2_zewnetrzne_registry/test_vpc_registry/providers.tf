  variable "aws_access_key" { type = string }
  variable "aws_secret_key" { type = string }

  provider "aws" {
    region     = "eu-north-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }