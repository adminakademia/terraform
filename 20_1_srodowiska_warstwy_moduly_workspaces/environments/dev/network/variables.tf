variable "environment" {
  type        = string
  description = "Nazwa srodowiska, w ktorym zyje ta warstwa."

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Srodowisko musi byc jednym z: dev, test, prod."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "Pula adresowa VPC tego srodowiska. Pule srodowisk MUSZA byc rozlaczne."
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Pula adresowa publicznej podsieci wewnatrz puli VPC."
}

variable "availability_zone" {
  type        = string
  description = "Strefa dostepnosci publicznej podsieci."
  default     = "eu-north-1a"
}