variable "aws_region" {
  type        = string
  description = "Region AWS."
  default     = "eu-north-1"
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
  default     = "10.130.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "Adresacja CIDR dla publicznej podsieci."
  default     = "10.130.1.0/24"
}