# TOZSAMOSC I WARTOSCI SRODOWISKA DEV.
# Ten plik JEST czescia definicji srodowiska - dlatego trafia do repozytorium.
# Sekrety (klucze AWS) NIGDY tu nie trafiaja: sa w zmiennych srodowiskowych.

aws_account_id           = "123456789012" # <- numer TWOJEGO konta AWS
environment              = "dev"
vpc_cidr_block           = "10.170.0.0/16"
public_subnet_cidr_block = "10.170.1.0/24"
instance_type            = "t3.micro"