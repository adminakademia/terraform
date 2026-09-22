# ============ TOZSAMOSC SRODOWISKA - CELOWO BEZ WARTOSCI DOMYSLNYCH ============
# Zasada: wartosc, ktorej pomylka jest droga, NIE dostaje wartosci domyslnej.
# Niech Terraform o nia zapyta, zamiast po cichu podstawic wartosc z innego srodowiska.

variable "aws_account_id" {
  type        = string
  description = "Numer konta AWS, w ktorym wolno wdrazac to srodowisko. Trafia do allowed_account_ids providera."

  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "Numer konta AWS musi skladac sie z dokladnie 12 cyfr (numer z wiodacym zerem tez - w cudzyslowie)."
  }
}

variable "environment" {
  type        = string
  description = "Nazwa srodowiska. MUSI odpowiadac nazwie katalogu i czlonowi klucza stanu w backend.tf."

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Srodowisko musi byc jednym z: dev, test, prod."
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "Pula adresowa CIDR VPC tego srodowiska. Pule srodowisk MUSZA byc rozlaczne."
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "Pula adresowa CIDR publicznej podsieci - podsiec /24 o indeksie 1 wewnatrz puli VPC (indeks 0 zostawiamy wolny na przyszla podsiec prywatna)."
}

variable "instance_type" {
  type        = string
  description = "Typ instancji EC2 dla tego srodowiska. Polityka kosztowa projektu dopuszcza wylacznie rodzine t3."

  validation {
    condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Polityka kosztowa projektu dopuszcza wylacznie t3.micro, t3.small i t3.medium."
  }
}

# ============ WARTOSCI WSPOLNE - Z SENSOWNYMI DOMYSLNYMI ============

variable "aws_region" {
  type        = string
  description = "Region AWS. Caly kurs pracuje w Sztokholmie."
  default     = "eu-north-1"
}

variable "availability_zone" {
  type        = string
  description = "Strefa dostepnosci dla publicznej podsieci."
  default     = "eu-north-1a"
}

variable "project_name" {
  type        = string
  description = "Nazwa projektu. Wchodzi w sklad przedrostka nazw i tagu Project."
  default     = "kurs-terraform"
}

variable "owner" {
  type        = string
  description = "Zespol lub osoba odpowiedzialna za srodowisko. Trafia do tagu Owner - to numer, pod ktory sie dzwoni."
  default     = "zespol-devops"
}

variable "cost_center" {
  type        = string
  description = "Centrum kosztow do rozliczen. Trafia do tagu CostCenter."
  default     = "DEVOPS-01"
}

variable "root_volume_size_gib" {
  type        = number
  description = "Rozmiar dysku glownego instancji w GiB."
  default     = 10
}

variable "ssh_cidr_blocks" {
  type        = list(string)
  description = "Pule CIDR dopuszczone do SSH. W srodowisku produkcyjnym NIGDY nie zostawiaj tu 0.0.0.0/0."
  default     = ["0.0.0.0/0"]
}