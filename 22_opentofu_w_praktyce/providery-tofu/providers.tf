# Provider "docker" rozmawia z silnikiem Dockera na Debianie - tunelem SSH
provider "docker" {
  host = "ssh://${var.uzytkownik_debiana}@${var.adres_debiana}:22"

  # SSH nie moze o nic pytac - zamiast zawieszenia od razu zglasza blad
  ssh_opts = ["-o", "BatchMode=yes"]

  # Inne mozliwosci:
  # host = "unix:///var/run/docker.sock"     # Terraform uruchamiany na samym Debianie
  # host = "npipe:////./pipe/docker_engine"  # Docker Desktop w Windows (ciekawostka 1)
}
