variable "obraz_nginx" {
  description = "Obraz kontenera z serwerem WWW w postaci repozytorium:tag - zawsze z konkretnym tagiem"
  type        = string
  default     = "nginx:1.30-alpine"
}

variable "adres_debiana" {
  description = "Adres IPv4 maszyny Debian z silnikiem Dockera (zaimportowanej z pliku OVA kursu)"
  type        = string

  validation {
    condition     = can(cidrnetmask("${var.adres_debiana}/32"))
    error_message = "Podaj adres IPv4 maszyny Debian, np. 192.168.56.101."
  }
}

variable "port_zewnetrzny" {
  description = "Port na maszynie Debian, pod ktorym bedzie dostepna strona z kontenera"
  type        = number
  default     = 8080

  validation {
    condition     = var.port_zewnetrzny >= 1024 && var.port_zewnetrzny <= 65535
    error_message = "Port zewnetrzny musi byc z zakresu 1024-65535."
  }
}

variable "uzytkownik_debiana" {
  description = "Uzytkownik na maszynie Debian (logowanie kluczem SSH, czlonek grupy docker)"
  type        = string
  default     = "kursant"
}
