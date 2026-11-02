# Zrodlo danych "http": zapytanie GET wykonywane przy KAZDYM planie
data "http" "moje_ip" {
  url = "https://checkip.amazonaws.com"

  lifecycle {
    # Provider "http" nie traktuje kodow 4xx/5xx jako bledu - sprawdzamy to sami
    postcondition {
      condition     = self.status_code == 200
      error_message = "Serwis checkip odpowiedzial kodem ${self.status_code} zamiast 200."
    }
    # Siec hotelowa albo serwer proxy potrafia zwrocic strone HTML z kodem 200
    postcondition {
      condition     = can(cidrnetmask("${chomp(self.response_body)}/32"))
      error_message = "Odpowiedz serwisu checkip nie jest adresem IPv4."
    }
  }
}
