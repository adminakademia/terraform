variable "aws_region" {
  type        = string
  description = "Region AWS."
  default     = "eu-north-1"
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

variable "root_volume_size" {
  type        = number
  description = "Rozmiar dysku glownego instancji EC2 w GiB."
  default     = 10
}
