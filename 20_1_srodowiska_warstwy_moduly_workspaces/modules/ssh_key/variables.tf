variable "key_name" {
  type        = string
  description = "Nazwa pary kluczy rejestrowanej w usludze EC2."

  validation {
    condition     = length(trimspace(var.key_name)) > 0
    error_message = "Nazwa pary kluczy nie moze byc pusta."
  }
}

variable "public_key" {
  type        = string
  description = "Tresc klucza publicznego SSH w formacie OpenSSH; modul nie przyjmuje klucza prywatnego."

  validation {
    condition = can(regex(
      "^(ssh-rsa|ssh-ed25519)[[:space:]]+",
      trimspace(var.public_key)
    ))
    error_message = "Klucz publiczny musi zaczynac sie od ssh-rsa albo ssh-ed25519."
  }
}

variable "tags" {
  type        = map(string)
  description = "Dodatkowe tagi przypisywane do pary kluczy EC2."
  default     = {}
}