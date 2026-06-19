# Zmienne wspolne dla wszystkich blokow run w tym pliku
variables {
  instance_type = "t3.micro"
}
 
 
# TEST 1: konfiguracja jest spojna i zgodna z zalozeniami
run "konfiguracja_podstawowa" {
  command = plan
 
  # czy aktualne srodowisko (workspace) ma dozwolona nazwe
  assert {
    condition     = contains(["default", "dev", "test", "prod"], terraform.workspace)
    error_message = "Niedozwolona nazwa workspace: ${terraform.workspace}. Dozwolone: default, dev, test, prod."
  }
 
  # czy tag Environment jest POWIAZANY z workspace (a nie wpisany na sztywno)
  assert {
    condition     = aws_instance.lekcja5_ec2_srv[0].tags["Environment"] == terraform.workspace
    error_message = "Tag Environment nie zgadza sie z aktualnym workspace."
  }
 
  # czy nazwa instancji zawiera oczekiwany fragment
  assert {
    condition     = strcontains(aws_instance.lekcja5_ec2_srv[0].tags["Name"], "sztokholm")
    error_message = "Nazwa instancji nie zawiera oczekiwanego fragmentu 'sztokholm'."
  }
 
  # czy lista pakietow dla cloud-init NIE jest pusta
  assert {
    condition     = length(local.cloud_init_packages) > 0
    error_message = "Lista pakietow cloud-init nie moze byc pusta."
  }
 
  # czy LICZBA instancji w Sztokholmie jest zgodna z oczekiwaniem (poza prod = 1 serwer)
  assert {
    condition     = length(aws_instance.lekcja5_ec2_srv) == 1
    error_message = "W srodowisku innym niz prod spodziewamy sie dokladnie 1 instancji w Sztokholmie."
  }
 
  # czy port HTTPS (443) jest zawsze otwarty w regulach zapory
  assert {
    condition     = contains([for r in local.ingress_rules : r.port], 443)
    error_message = "Port 443 (HTTPS) powinien byc zawsze otwarty."
  }
 
  # czy WARTOSC outputu zawiera nazwe aktualnego workspace (przyklad warunku testowego na OUTPUCIE)
  # uwaga: testujemy output znany juz na etapie "plan" (patrz Krok 1b) - nie oparty na public_ip/id
  assert {
    condition     = strcontains(output.nazwa_glownego_serwera, terraform.workspace)
    error_message = "Output 'nazwa_glownego_serwera' powinien zawierac nazwe aktualnego workspace."
  }
}
 
 
# TEST 2: niedozwolony typ instancji ma zostac ODRZUCONY (test negatywny)
run "niedozwolony_typ_instancji_jest_odrzucany" {
  command = plan
 
  # nadpisujemy zmienna na wartosc spoza dozwolonej listy
  variables {
    instance_type = "t3.xlarge"
  }
 
  # spodziewamy sie, ze walidacja zmiennej instance_type ZAWIEDZIE
  expect_failures = [
    var.instance_type
  ]
}