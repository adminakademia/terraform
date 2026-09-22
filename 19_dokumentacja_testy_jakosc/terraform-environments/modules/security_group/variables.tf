variable "name_prefix" {
  type        = string
  description = "Prefiks uzywany w nazwie i tagu Name grupy bezpieczenstwa."
}

variable "vpc_id" {
  type        = string
  description = "ID VPC, w ktorym ma powstac grupa bezpieczenstwa."
}

variable "vpc_cidr_block" {
  type        = string
  description = "Pula IPv4 calego VPC uzywana w regule ruchu wewnetrznego."

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "vpc_cidr_block musi byc poprawna pula IPv4 w notacji CIDR."
  }
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "Niepusta lista pul IPv4, dla ktorych modul tworzy osobne reguly SSH na porcie 22."

  validation {
    condition = (
      length(var.ssh_cidr_blocks) > 0 &&
      alltrue([for cidr in var.ssh_cidr_blocks : can(cidrnetmask(cidr))])
    )
    error_message = "ssh_cidr_blocks musi zawierac co najmniej jedna poprawna pule IPv4 CIDR."
  }
}

variable "http_cidr_blocks" {
  type        = list(string)
  description = "Niepusta lista pul IPv4, dla ktorych modul tworzy osobne reguly HTTP na porcie 80."

  validation {
    condition = (
      length(var.http_cidr_blocks) > 0 &&
      alltrue([for cidr in var.http_cidr_blocks : can(cidrnetmask(cidr))])
    )
    error_message = "http_cidr_blocks musi zawierac co najmniej jedna poprawna pule IPv4 CIDR."
  }
}
variable "tags" {
  type        = map(string)
  description = "Dodatkowe tagi przypisywane do grupy bezpieczenstwa."
  default     = {}
}