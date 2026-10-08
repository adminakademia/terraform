output "vpc_id" {
  description = "Identyfikator sieci VPC platformy."
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "Pula adresowa sieci VPC platformy."
  value       = module.network.vpc_cidr_block
}

output "security_group_id" {
  description = "Identyfikator zapory (security group) platformy."
  value       = module.security_group.security_group_id
}