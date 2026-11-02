output "nazwa_kontenera" {
  description = "Wylosowana nazwa - w sekcji 4 uzyjemy jej jako nazwy kontenera"
  value       = random_pet.nazwa.id
}

output "moje_ip_cidr" {
  description = "Publiczny adres IP tego komputera w notacji CIDR /32 (np. do reguly SSH w zaporze)"
  value       = local.moje_ip_cidr
  sensitive   = true # adres IP nie musi trafiac na ekran, do nagran ani do logow
}

output "adres_strony" {
  description = "Adres strony WWW serwowanej przez kontener na Debianie"
  value       = "http://${var.adres_debiana}:${docker_container.web.ports[0].external}"
}
