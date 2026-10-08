variable "instance_name" {
  type        = string
  description = "Wartosc tagu Name tworzonej instancji EC2."
}

variable "ami_id" {
  type        = string
  description = "ID obrazu AMI uzywanego do uruchomienia instancji."
}

variable "instance_type" {
  type        = string
  description = "Typ instancji EC2, na przyklad t3.micro."
}

variable "subnet_id" {
  type        = string
  description = "ID podsieci, w ktorej ma powstac instancja."
}

variable "security_group_id" {
  type        = string
  description = "ID grupy bezpieczenstwa przypisanej do instancji."
}

variable "key_name" {
  type        = string
  description = "Nazwa pary kluczy EC2 uzywanej do logowania przez SSH."
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Okresla, czy interfejs sieciowy instancji ma otrzymac publiczny adres IPv4."
}

variable "root_volume_size_gib" {
  type        = number
  description = "Rozmiar glownego wolumenu EBS w GiB."

  validation {
    condition     = var.root_volume_size_gib > 0
    error_message = "Rozmiar glownego wolumenu musi byc wiekszy od zera."
  }
}

variable "user_data" {
  type        = string
  description = "Opcjonalna konfiguracja startowa przekazywana jako user data."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Dodatkowe tagi przypisywane do instancji."
  default     = {}
}
