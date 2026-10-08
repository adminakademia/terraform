variable "name_prefix" {
  type        = string
  description = "Prefiks uzywany w nazwach i tagach zasobow sieciowych."

  validation {
    condition     = length(trimspace(var.name_prefix)) > 0
    error_message = "Prefiks nazwy nie moze byc pusty."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "Pula adresowa IPv4 dla VPC, zapisana w notacji CIDR."

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "vpc_cidr_block musi byc poprawna pula IPv4 w notacji CIDR."
  }
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Pula adresowa IPv4 publicznej podsieci, zapisana w notacji CIDR."

  validation {
    condition     = can(cidrnetmask(var.public_subnet_cidr_block))
    error_message = "public_subnet_cidr_block musi byc poprawna pula IPv4 w notacji CIDR."
  }
}

variable "availability_zone" {
  type        = string
  description = "Strefa dostepnosci, w ktorej ma powstac publiczna podsiec."

  validation {
    condition     = length(trimspace(var.availability_zone)) > 0
    error_message = "Strefa dostepnosci nie moze byc pusta."
  }
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Okresla, czy VPC ma nadawac instancjom nazwy DNS."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Dodatkowe tagi przypisywane do zasobow modulu."
  default     = {}
}