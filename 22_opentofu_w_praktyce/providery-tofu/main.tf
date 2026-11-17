# Losowa, ale STABILNA nazwa - losowana raz, przy tworzeniu, i zapamietywana w stanie
resource "random_pet" "nazwa" {
  prefix = "lab21"
  length = 2

  # Nowa nazwa TYLKO wtedy, gdy zmieni sie obraz kontenera (sekcja 2)
  keepers = {
    obraz = var.obraz_nginx
  }
}

# Obraz kontenera - odpowiednik AMI
resource "docker_image" "nginx" {
  name         = var.obraz_nginx
  keep_locally = false # przy destroy usun obraz z dysku
}

# Kontener - odpowiednik instancji EC2
resource "docker_container" "web" {
  name  = random_pet.nazwa.id
  image = docker_image.nginx.image_id

  # Mapowanie portu: port na Debianie -> port 80 w kontenerze
  ports {
    internal = 80
    external = var.port_zewnetrzny
  }

  # Wlasna strona startowa wgrana do kontenera
  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = local.strona_html
  }
}
