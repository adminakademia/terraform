variable "name_prefix" {
  type        = string
  description = "Prefiks nazwy zasobow tworzonych przez modul network."
}

variable "cidr_block" {
  type        = string
  description = "Adresacja CIDR dla VPC, np. 10.120.0.0/16."
}

variable "subnet_cidr" {
  type        = string
  description = "Adresacja CIDR dla publicznej podsieci, np. 10.120.1.0/24."
}

variable "availability_zone" {
  type        = string
  description = "Strefa dostepnosci dla podsieci, np. eu-north-1a."
}

variable "tags" {
  type        = map(string)
  description = "Wspolne tagi przypisywane do zasobow."
  default     = {}
}