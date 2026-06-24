output "security_group_id" {
  description = "ID utworzonej Security Group."
  value       = aws_security_group.this.id
}