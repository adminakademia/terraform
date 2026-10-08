# Tablica przylaczy: odczyt OUTPUTOW warstwy network z JEJ pliku stanu (lekcja 15).
data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "tfstate-604598162949-eu-north-1"        # <- nazwa TWOJEGO kubelka
    key    = "lekcja20/dev/network/terraform.tfstate" # <- klucz stanu warstwy NETWORK (nie naszej!)
    region = "eu-north-1"
  }
}