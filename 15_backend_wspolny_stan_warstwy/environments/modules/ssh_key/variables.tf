variable "key_name" {
  type        = string
  description = "Nazwa klucza SSH w AWS."
}

variable "public_key" {
  type        = string
  description = "Tresc klucza publicznego SSH."
}

variable "tags" {
  type        = map(string)
  description = "Wspolne tagi."
  default     = {}
}

