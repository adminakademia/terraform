output "instance_id" {
  description = "ID utworzonej instancji EC2."
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Publiczny adres IP instancji EC2."
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "Publiczna nazwa DNS instancji EC2."
  value       = aws_instance.this.public_dns
}