variable "name_prefix" {
  type        = string
  description = "Prefiks nazwy Security Group."
}

variable "vpc_id" {
  type        = string
  description = "ID VPC, w ktorym powstanie Security Group."
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "Lista pul CIDR, z ktorych dozwolony jest dostep SSH."
}

variable "http_cidr_blocks" {
  type        = list(string)
  description = "Lista pul CIDR, z ktorych dozwolony jest dostep HTTP."
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  description = "Wspolne tagi."
  default     = {}
}