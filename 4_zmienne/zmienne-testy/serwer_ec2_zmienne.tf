## Zmienne:


provider "aws" {
  region = "eu-north-1"
}


resource "aws_instance" "moj_pierwszy_srv_terrafom1" {
  ami           = "ami-0e63a5a9c1c7e5563" 
  instance_type = var.typ_instancji_serwera

  tags = {
    Name = "moj_pierwszy_srv_terrafom1"
  }
}

resource "aws_instance" "moj_pierwszy_srv_terrafom2" {
  ami           = "ami-0e63a5a9c1c7e5563" 
  instance_type = var.typ_instancji_serwera

  tags = {
    Name = "moj_pierwszy_srv_terrafom2"
  }
}

resource "aws_instance" "moj_pierwszy_srv_terrafom3" {
  ami           = "ami-0e63a5a9c1c7e5563" 
  instance_type = var.typ_instancji_serwera

  tags = {
    Name = "moj_pierwszy_srv_terrafom3"
  }
}
