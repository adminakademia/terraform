terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
  # Klucze dostepowe pobierane automatycznie ze zmiennych srodowiskowych:
  # AWS_ACCESS_KEY_ID oraz AWS_SECRET_ACCESS_KEY
}

# Kim jestem? - data source zwracajacy m.in. numer naszego konta AWS
data "aws_caller_identity" "current" {}

locals {
  bucket_name = "tfstate-${data.aws_caller_identity.current.account_id}-eu-north-1"
}


# 1) Kubelek na pliki stanu
resource "aws_s3_bucket" "tfstate" {
  bucket = local.bucket_name

  # UWAGA - ustawienie LABORATORYJNE: pozwala usunac kubelek razem z cala zawartoscia
  # (w tym wszystkimi wersjami plikow stanu) jednym "terraform destroy".
  # W PRODUKCJI tego NIE ustawiamy - wrecz przeciwnie, dodaje sie lifecycle { prevent_destroy = true }.
  force_destroy = true

  tags = {
    Name      = local.bucket_name
    Cel       = "Pliki stanu Terraform"
    ManagedBy = "Terraform"
  }
}

# 2) Wersjonowanie - kazdy zapis stanu tworzy NOWA WERSJE obiektu (wehikul czasu / kopia zapasowa)
resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 3) Szyfrowanie "w spoczynku" - kazdy obiekt zapisywany w kubelku jest szyfrowany po stronie serwera
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4) Calkowita blokada dostepu publicznego - stan NIGDY nie moze byc publiczny
resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  description = "Nazwa kubelka na pliki stanu - uzyjemy jej w konfiguracji backendow."
  value       = aws_s3_bucket.tfstate.bucket
}