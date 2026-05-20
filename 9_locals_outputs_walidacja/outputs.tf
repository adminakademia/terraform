# Publiczny IP serwera w Sztokholmie - najprostszy output
output "ip" {
  description = "Publiczny adres IP instancji EC2 w Sztokholmie"
  value       = aws_instance.lekcja5_ec2_srv.public_ip

    precondition {
    condition     = aws_instance.lekcja5_ec2_srv.public_ip != ""
    error_message = "Output 'ip' nie moze byc pusty - cos poszlo nie tak z przydzielaniem publicznego IP."
  }
}


# Publiczne IP wszystkich serwerów - mapa region -> IP
output "wszystkie_ip" {
  description = "Publiczne IP serwerow EC2 we wszystkich regionach"
  value = {
    eu-north-1   = aws_instance.lekcja5_ec2_srv.public_ip
    eu-central-1 = aws_instance.lekcja5_eu-central-1_ec2_srv.public_ip
    eu-west-2    = aws_instance.lekcja5_eu-west-2_ec2_srv.public_ip
  }
}
 
# Gotowe polecenie SSH do Sztokholmu - przydatne kopiowanie/wklejanie
output "ssh_command" {
  description = "Gotowe polecenie SSH do podlaczenia do Sztokholmu"
  value       = "ssh -i testowyklucz ubuntu@${aws_instance.lekcja5_ec2_srv.public_ip}"
}


# Przykladowe haslo - oznaczone jako sensitive
output "ssh_user_password" {
  description = "Tymczasowe haslo dla uzytkownika na serwerze (przyklad)"
  value       = "TajneHaslo123_${aws_instance.lekcja5_ec2_srv.id}"
  sensitive   = true
}
