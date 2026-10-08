output "security_group_id" {
  description = "ID utworzonej Security Group."
  value       = aws_security_group.this.id
}

output "security_group_name" {
  description = "Nazwa Security Group zbudowana wewnatrz modulu. Bez tego outputu kazdy, kto jej potrzebuje, musialby odtworzyc konwencje nazewnicza modulu u siebie."
  value       = aws_security_group.this.name
}
