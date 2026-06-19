# Publiczny IP serwera w Sztokholmie - najprostszy output
# Output "ip" - bierzemy PIERWSZĄ instancję [0] jako "główną":
output "ip" {
  description = "Publiczny adres IP glownej instancji EC2 w Sztokholmie"
  value       = aws_instance.lekcja5_ec2_srv[0].public_ip

  precondition {
    condition     = aws_instance.lekcja5_ec2_srv[0].public_ip != ""
    error_message = "Output 'ip' nie moze byc pusty - cos poszlo nie tak z przydzielaniem publicznego IP."
  }
}



# Publiczne IP wszystkich serwerów - mapa region -> IP
# Output "wszystkie_ip" - dla Sztokholmu używamy splat [*], bo instancji może być kilka:
output "wszystkie_ip" {
  description = "Publiczne IP serwerow EC2 we wszystkich regionach"
  value = {
    eu-north-1   = aws_instance.lekcja5_ec2_srv[*].public_ip
    eu-central-1 = aws_instance.lekcja5_eu-central-1_ec2_srv.public_ip
    eu-west-2    = aws_instance.lekcja5_eu-west-2_ec2_srv.public_ip
  }
}

# Output "ssh_command" - logujemy się do głównej instancji [0]:
output "ssh_command" {
  description = "Gotowe polecenie SSH do podlaczenia do Sztokholmu"
  value       = "ssh -i testowyklucz ubuntu@${aws_instance.lekcja5_ec2_srv[0].public_ip}"
}


# Przykladowe haslo - oznaczone jako sensitive
# Output "ssh_user_password" - również [0]:
output "ssh_user_password" {
  description = "Tymczasowe haslo dla uzytkownika na serwerze (przyklad)"
  value       = "TajneHaslo123_${aws_instance.lekcja5_ec2_srv[0].id}"
  sensitive   = true
}



output "znalezione_ami" {
  description = "Identyfikatory najnowszych AMI Ubuntu znalezione w 3 regionach"
  value = {
    eu-north-1   = data.aws_ami.ubuntu_najnowszy.id
    eu-central-1 = data.aws_ami.ubuntu_najnowszy_eu-central-1.id
    eu-west-2    = data.aws_ami.ubuntu_najnowszy_eu-west-2.id
  }
}

output "data_publikacji_ami" {
  description = "Daty publikacji znalezionych AMI"
  value = {
    eu-north-1   = data.aws_ami.ubuntu_najnowszy.creation_date
    eu-central-1 = data.aws_ami.ubuntu_najnowszy_eu-central-1.creation_date
    eu-west-2    = data.aws_ami.ubuntu_najnowszy_eu-west-2.creation_date
  }
}

output "az_sztokholm" {
  description = "Strefy dostepnosci w regionie eu-north-1"
  value       = data.aws_availability_zones.sztokholm.names
}

output "moje_konto_aws" {
  description = "Identyfikator konta AWS uzywanego przez Terraform"
  value       = data.aws_caller_identity.current.account_id
}

output "moj_arn" {
  description = "ARN uzytkownika AWS uzywanego przez Terraform"
  value       = data.aws_caller_identity.current.arn
}

output "domyslny_region" {
  description = "Domyslny region, w ktorym pracuje Terraform"
  value       = data.aws_region.current.name
}


output "nazwa_glownego_serwera" {
  description = "Nazwa (tag Name) glownej instancji EC2 w Sztokholmie"
  value       = aws_instance.lekcja5_ec2_srv[0].tags["Name"]
}