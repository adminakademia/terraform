locals {
  # Odpowiedz konczy sie znakiem nowej linii - chomp() go usuwa (lekcja 10)
  moje_ip      = chomp(data.http.moje_ip.response_body)
  moje_ip_cidr = "${local.moje_ip}/32"

  # Strona startowa kontenera - odpowiednik strony z cloud-init w AWS
  strona_html = <<-EOT
    <!DOCTYPE html>
    <html lang="pl">
    <head><meta charset="UTF-8"><title>Lekcja 21 - ${random_pet.nazwa.id}</title></head>
    <body style="font-family: Arial, sans-serif; text-align: center; padding: 50px;">
      <h1>Kontener: ${random_pet.nazwa.id}</h1>
      <p>Obraz: ${var.obraz_nginx}</p>
      <p>Trzy providery, jeden plan: random + http + docker</p>
    </body>
    </html>
  EOT
}
