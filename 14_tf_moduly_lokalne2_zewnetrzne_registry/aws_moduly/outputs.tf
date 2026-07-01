output "vpc_id" {
  description = "ID VPC."
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID publicznej podsieci."
  value       = module.network.public_subnet_id
}

output "security_group_id" {
  description = "ID Security Group."
  value       = module.security_group.security_group_id
}

output "ec2_public_ips" {
  description = "Publiczne adresy IP wszystkich instancji EC2."
  value = {
    for name, instance in module.ec2_instances :
    name => instance.public_ip
  }
}

output "vpc_cidr" {
  description = "Adresacja CIDR utworzonego VPC."
  value       = module.network.vpc_cidr_block
}