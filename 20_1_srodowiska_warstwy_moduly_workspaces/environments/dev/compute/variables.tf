variable "environment" {
  type        = string
  description = "Nazwa srodowiska, w ktorym zyje ta warstwa."

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Srodowisko musi byc jednym z: dev, test, prod."
  }
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "Pule IPv4 dopuszczone do SSH. Decyzja zespolu aplikacji."
}