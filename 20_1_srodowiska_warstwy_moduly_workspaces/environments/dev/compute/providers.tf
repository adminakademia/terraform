provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Project     = "kurs-terraform"
      Lekcja      = "20"
      ManagedBy   = "Terraform"
      Environment = var.environment
      Layer       = "compute"
    }
  }
}