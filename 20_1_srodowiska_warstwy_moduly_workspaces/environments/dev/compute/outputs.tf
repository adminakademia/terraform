output "security_group_id" {
  description = "Identyfikator zapory warstwy compute."
  value       = module.security_group.security_group_id
}

output "security_group_name" {
  description = "Nazwa zapory warstwy compute."
  value       = module.security_group.security_group_name
}
