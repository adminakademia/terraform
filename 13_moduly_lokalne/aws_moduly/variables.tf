variable "aws_region" {
  type        = string
  description = "Region AWS."
  default     = "eu-north-1"
}

variable "aws_access_key" {
  type        = string
  description = "Klucz dostepowy AWS."
}

variable "aws_secret_key" {
  type        = string
  description = "Tajny klucz dostepowy AWS."
}

variable "availability_zone" {
  type        = string
  description = "Strefa dostepnosci dla podsieci."
  default     = "eu-north-1a"
}

variable "project_name" {
  type        = string
  description = "Nazwa projektu."
  default     = "kurs-terraform"
}

variable "environment" {
  type        = string
  description = "Nazwa srodowiska."
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Srodowisko musi byc jednym z: dev, test, prod."
  }
}

variable "vpc_cidr" {
  type        = string
  description = "Adresacja CIDR dla VPC."
  default     = "10.120.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "Adresacja CIDR dla publicznej podsieci."
  default     = "10.120.1.0/24"
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "Pule CIDR dopuszczone do SSH."
  default     = ["0.0.0.0/0"]
}

variable "instance_type" {
  type        = string
  description = "Typ instancji EC2."
  default     = "t3.micro"
}

variable "instances" {
  type = map(object({
    instance_type = string
    name_suffix   = string
  }))

  default = {
    web1 = {
      instance_type = "t3.micro"
      name_suffix   = "web1"
    }
    web2 = {
      instance_type = "t3.micro"
      name_suffix   = "web2"
    }
  }

  description = "Mapa instancji EC2 do utworzenia (klucz = identyfikator, wartosc = parametry)."
}