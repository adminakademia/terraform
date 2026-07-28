# CELOWO BLEDNY plik: wartosci srodowiska PROD w katalogu DEV.
# Nazwa jest specjalnie inna niz "terraform.tfvars" i nie konczy sie na ".auto.tfvars",
# zeby Terraform NIE wczytal go sam - podamy go jawnie flaga.
environment              = "prod"
vpc_cidr_block           = "10.190.0.0/16"
public_subnet_cidr_block = "10.190.1.0/24"
instance_type            = "t3.medium"