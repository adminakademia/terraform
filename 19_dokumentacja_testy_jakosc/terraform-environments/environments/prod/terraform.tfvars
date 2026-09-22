# TOZSAMOSC I WARTOSCI SRODOWISKA DEV.
# Ten plik JEST czescia definicji srodowiska - dlatego trafia do repozytorium.
# Sekrety (klucze AWS) NIGDY tu nie trafiaja: sa w zmiennych srodowiskowych.

aws_account_id           = "123456789012"    # <- numer TWOJEGO konta AWS
environment              = "prod"            # <- roznica nr 2: nazwa srodowiska
vpc_cidr_block           = "10.190.0.0/16"   # <- roznica nr 3: pula adresowa VPC
public_subnet_cidr_block = "10.190.1.0/24"   # <- roznica nr 4: podsiec /24 o indeksie 1 w tej puli
instance_type            = "t3.medium"       # <- roznica nr 5: rozmiar maszyny
ssh_cidr_blocks          = ["10.190.0.0/16"] # <- wartosc WYLACZNIE produkcyjna, jedyna niekosmetyczna