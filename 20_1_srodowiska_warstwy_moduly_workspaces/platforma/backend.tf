terraform {
  backend "s3" {
    bucket       = "tfstate-604598162949-eu-north-1" # <- nazwa TWOJEGO kubelka z lekcji 15
    key          = "lekcja20/platforma/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
