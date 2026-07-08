output "vpc_id" {
  description = "ID VPC srodowiska dev."
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID publicznej podsieci srodowiska dev."
  value       = module.network.public_subnet_id
}

output "vpc_cidr_block" {
  description = "Adresacja CIDR VPC srodowiska dev."
  value       = module.network.vpc_cidr_block
}