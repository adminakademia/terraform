output "vpc_id" {
  description = "ID utworzonego VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID publicznej podsieci."
  value       = aws_subnet.public.id
}

output "internet_gateway_id" {
  description = "ID Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  description = "ID publicznej tablicy routingu."
  value       = aws_route_table.public.id
}

output "vpc_cidr_block" {
  description = "Adresacja CIDR VPC."
  value       = aws_vpc.this.cidr_block
}