output "key_name" {
  description = "Nazwa pary kluczy zarejestrowanej w usludze EC2."
  value       = aws_key_pair.this.key_name
}

output "key_pair_id" {
  description = "Identyfikator pary kluczy zwrocony przez AWS."
  value       = aws_key_pair.this.key_pair_id
}

output "fingerprint" {
  description = "Fingerprint materialu klucza publicznego raportowany przez AWS; nie jest to klucz hosta pokazywany przy pierwszym polaczeniu SSH."
  value       = aws_key_pair.this.fingerprint
}