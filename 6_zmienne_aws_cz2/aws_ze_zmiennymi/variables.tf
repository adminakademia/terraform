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


variable "regional_amis" {
  description = "Mapa identyfikatorow AMI w zaleznosci od regionu"
  type        = map(string)
  default = {
    "eu-north-1"   = "ami-01ef747f983799d6f" # AMI dla Sztokholmu
    "eu-central-1" = "ami-0da1f66573556d917" # AMI dla Frankfurtu
    "eu-west-2"    = "ami-073f149603898e301" # AMI dla Londynu
  }
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
}
