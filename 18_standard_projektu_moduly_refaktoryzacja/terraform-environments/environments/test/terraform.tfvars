# TOZSAMOSC I WARTOSCI SRODOWISKA DEV.
# Ten plik JEST czescia definicji srodowiska - dlatego trafia do repozytorium.
# Sekrety (klucze AWS) NIGDY tu nie trafiaja: sa w zmiennych srodowiskowych.

aws_account_id           = "604598162949" # <- numer TWOJEGO konta AWS
environment              = "test"
vpc_cidr_block           = "10.180.0.0/16"
public_subnet_cidr_block = "10.180.1.0/24"
instance_type            = "t3.small"