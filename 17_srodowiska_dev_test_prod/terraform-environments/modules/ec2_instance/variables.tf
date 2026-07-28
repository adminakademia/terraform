variable "name" {
  type        = string
  description = "Nazwa instancji EC2."
}

variable "ami_id" {
  type        = string
  description = "AMI ID systemu operacyjnego."
}

variable "instance_type" {
  type        = string
  description = "Typ instancji EC2, np. t3.micro."
}

variable "subnet_id" {
  type        = string
  description = "ID podsieci, w ktorej powstanie instancja."
}

variable "security_group_id" {
  type        = string
  description = "ID Security Group przypisanej do instancji."
}

variable "key_name" {
  type        = string
  description = "Nazwa klucza SSH w AWS."
}

variable "user_data" {
  type        = string
  description = "Opcjonalna konfiguracja startowa user_data/cloud-init."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Wspolne tagi."
  default     = {}
}

variable "root_volume_size" {
  type        = number
  description = "Rozmiar dysku glownego instancji w GiB."
}