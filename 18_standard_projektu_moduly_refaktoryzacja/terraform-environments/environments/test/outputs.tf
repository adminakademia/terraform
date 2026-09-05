output "kontekst_wdrozenia" {
  description = "Kto, gdzie i pod jakim kluczem stanu - do sprawdzenia PRZED kazdym apply."
  value = {
    konto       = data.aws_caller_identity.current.account_id
    region      = var.aws_region
    srodowisko  = var.environment
    klucz_stanu = "lesson17/${var.environment}/terraform.tfstate"
  }
}

# Dwa ponizsze outputy sa dla MASZYNY, nie dla czlowieka: wystawiaja to,
# co policzylismy w "locals.tf", zeby moglo to sprawdzic narzedzie (lekcja 18, sekcja 4).
output "name_prefix" {
  description = "Przedrostek nazw zasobow tego srodowiska - wystawiony do kontroli przez straznika standardu."
  value       = local.name_prefix
}

output "common_tags" {
  description = "Tagi organizacyjne doklejane przez default_tags - wystawione do kontroli przez straznika standardu."
  value       = local.common_tags
}

output "vpc_id" {
  description = "Identyfikator VPC tego srodowiska."
  value       = module.network.vpc_id
}

output "ec2_instance_id" {
  description = "Identyfikator instancji EC2."
  value       = module.ec2_instance.instance_id
}

output "ec2_public_ip" {
  description = "Publiczny adres IP instancji - do logowania SSH i do testu w przegladarce."
  value       = module.ec2_instance.public_ip
}

output "ec2_public_dns" {
  description = "Publiczna nazwa DNS instancji."
  value       = module.ec2_instance.public_dns
}