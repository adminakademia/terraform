provider "aws" {
  region = "eu-north-1"

  # Tagi doklejane do KAZDEGO zasobu - takze tworzonego wewnatrz modulow (lekcja 17).
  # Tag "lekcja" wykorzystuje nasza sonda do odnajdywania dzisiejszych sieci.
  default_tags {
    tags = {
      Project   = "kurs-terraform"
      Lekcja    = "20"
      ManagedBy = "Terraform"
    }
  }
}