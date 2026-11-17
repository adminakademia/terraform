# Ciagla weryfikacja: czy strona odpowiada? Niepowodzenie = OSTRZEZENIE, nie blad
check "strona_odpowiada" {
  # Zrodlo danych, ktore sluzy tylko temu sprawdzeniu
  data "http" "strona" {
    url = "http://${var.adres_debiana}:${var.port_zewnetrzny}"

    # Serwer WWW potrzebuje chwili na start - ponawiamy probe (lacznie do 4 prob)
    retry {
      attempts     = 3
      min_delay_ms = 500
    }
  }

  assert {
    condition     = data.http.strona.status_code == 200
    error_message = "Strona http://${var.adres_debiana}:${var.port_zewnetrzny} nie odpowiada kodem 200."
  }
}
