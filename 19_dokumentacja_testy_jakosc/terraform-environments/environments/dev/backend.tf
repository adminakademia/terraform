terraform {
  backend "s3" {
    bucket       = "tfstate-123456789012-eu-north-1" # <- nazwa TWOJEGO kubelka z lekcji 15
    key          = "lesson17/dev/terraform.tfstate"  # <- TOZSAMOSC tego srodowiska
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}