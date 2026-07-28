output "key_name" {
  description = "Nazwa klucza SSH utworzonego w AWS."
  value       = aws_key_pair.this.key_name
}