# INTERFEJS WARSTWY: tylko te wartosci zobaczy warstwa compute (lekcja 15).

output "vpc_id" {
  description = "Identyfikator VPC - na nim warstwa compute stawia swoje zasoby."
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "Pula adresowa VPC - potrzebna regule ruchu wewnetrznego w zaporze."
  value       = module.network.vpc_cidr_block
}

output "public_subnet_id" {
  description = "Identyfikator publicznej podsieci - dla przyszlych maszyn warstwy compute."
  value       = module.network.public_subnet_id
}