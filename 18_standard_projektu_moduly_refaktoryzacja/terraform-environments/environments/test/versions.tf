terraform {
  required_version = ">= 1.11.0, < 2.0.0" # use_lockfile wymaga nowszego CLI niz moduly

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # SUFIT: to root module - to on ponosi ryzyko aktualizacji
    }
  }
}