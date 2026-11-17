terraform {
  required_version = ">= 1.5.0, < 2.0.0" # blok "check" (sekcja 3) pojawil sie w Terraform 1.5

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.9"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.6"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.6"
    }
  }
}
