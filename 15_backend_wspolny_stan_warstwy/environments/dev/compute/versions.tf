terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-604598162949-eu-north-1" # <- nazwa TWOJEGO kubelka
    key          = "dev/compute/terraform.tfstate"   # <- WLASNY klucz tej warstwy!
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}