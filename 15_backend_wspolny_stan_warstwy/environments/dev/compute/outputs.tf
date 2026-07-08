output "ec2_instance_id" {
  description = "ID instancji EC2."
  value       = module.ec2_instance.instance_id
}

output "ec2_public_ip" {
  description = "Publiczny adres IP instancji EC2."
  value       = module.ec2_instance.public_ip
}

output "ec2_public_dns" {
  description = "Publiczna nazwa DNS instancji EC2."
  value       = module.ec2_instance.public_dns
}