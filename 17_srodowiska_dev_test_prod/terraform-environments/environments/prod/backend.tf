terraform {
  backend "s3" {
    bucket       = "tfstate-604598162949-eu-north-1" # <- nazwa TWOJEGO kubelka z lekcji 15
    key          = "lesson17/prod/terraform.tfstate"   # <- TOZSAMOSC tego srodowiska
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}