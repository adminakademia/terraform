# Haslo do stanu NIE trafia do kodu - podajemy je w zmiennej srodowiskowej TF_VAR_haslo_stanu
variable "haslo_stanu" {
  description = "Haslo do szyfrowania stanu i planu (co najmniej 16 znakow)"
  type        = string
  sensitive   = true
}

terraform {
  encryption {
    # Klucz wyliczany z hasla (PBKDF2)
    key_provider "pbkdf2" "haslo" {
      passphrase = var.haslo_stanu
    }

    # Szyfr AES-GCM z kluczem z hasla
    method "aes_gcm" "szyfr" {
      keys = key_provider.pbkdf2.haslo
    }

    # Stan zapisujemy WYLACZNIE zaszyfrowany
    state {
      method   = method.aes_gcm.szyfr
      enforced = true
    }

    # To samo dla planow zapisywanych do pliku ("-out")
    plan {
      method   = method.aes_gcm.szyfr
      enforced = true
    }
  }
}
