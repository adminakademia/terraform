variable "aws_access_key" {
  description = "Klucz API - AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "Klucz API - AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "Domyslny typ instancji dla wszystkich serwerow EC2"
  type        = string
  default     = "t3.micro"
}


variable "network_config" {
  description = "Konfiguracja adresacji sieciowej dla regionow"
  type = map(object({
    vpc_cidr          = string
    subnet_cidr       = string
    region            = string
    availability_zone = string
  }))

  default = {
    "eu-north-1" = {
      vpc_cidr          = "10.10.0.0/16"
      subnet_cidr       = "10.10.1.0/24"
      region            = "eu-north-1"
      availability_zone = "eu-north-1a"
    }

    "eu-central-1" = {
      vpc_cidr          = "10.20.0.0/16"
      subnet_cidr       = "10.20.1.0/24"
      region            = "eu-central-1"
      availability_zone = "eu-central-1a"
    }
    "eu-west-2" = {
      vpc_cidr          = "10.30.0.0/16"
      subnet_cidr       = "10.30.1.0/24"
      region            = "eu-west-2"
      availability_zone = "eu-west-2a"
    }
  }

 # Walidacja 1: Wszystkie VPC CIDR muszą być prawidłowymi adresami CIDR
  validation {
    condition = alltrue([
      for k, v in var.network_config : can(cidrnetmask(v.vpc_cidr))
    ])
    error_message = "Wszystkie wartosci vpc_cidr musza byc prawidlowymi adresami CIDR (np. 10.0.0.0/16)."
  }
 
  # Walidacja 2: Wszystkie VPC i Subnet CIDR muszą być z puli RFC1918 (adresy prywatne)
  validation {
    condition = alltrue([
      for k, v in var.network_config : (
        startswith(v.vpc_cidr, "10.") ||
        startswith(v.vpc_cidr, "172.16.") ||
        startswith(v.vpc_cidr, "172.17.") ||
        startswith(v.vpc_cidr, "172.18.") ||
        startswith(v.vpc_cidr, "172.19.") ||
        startswith(v.vpc_cidr, "172.2") ||
        startswith(v.vpc_cidr, "172.30.") ||
        startswith(v.vpc_cidr, "172.31.") ||
        startswith(v.vpc_cidr, "192.168.")
      )
    ])
    error_message = "Wszystkie vpc_cidr musza byc adresami prywatnymi z puli RFC1918 (10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16)."
  }
 
  # Walidacja 3: Subnet musi miec wezsza maske niz VPC (czyli wiekszy numer po /)
  validation {
    condition = alltrue([
      for k, v in var.network_config : (
        tonumber(split("/", v.subnet_cidr)[1]) > tonumber(split("/", v.vpc_cidr)[1])
      )
    ])
    error_message = "Maska podsieci (subnet_cidr) musi byc wezsza (wiekszy numer po /) niz maska VPC (vpc_cidr)."
  }

  }
