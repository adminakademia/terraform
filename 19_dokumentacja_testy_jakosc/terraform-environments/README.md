# Środowiska Terraform: dev, test i prod

Projekt pokazuje jawne rozdzielenie środowisk przez osobne moduły główne, klucze stanu i wartości środowiskowe.

## Struktura

    environments/
      dev/
      test/
      prod/
    modules/
      network/
      security_group/
      ssh_key/
      ec2_instance/

## Wymagania

- Terraform w zakresie zadeklarowanym w "environments/*/versions.tf".
- Provider AWS w zakresie zadeklarowanym przez moduły główne.
- Program AWS CLI, czyli polecenie "aws", do sprawdzania bieżącego konta oraz roli lub użytkownika.
- terraform-docs do generowania sekcji technicznych README modułów.
- Kubełek S3 do przechowywania zdalnych plików stanu Terraform, utworzony przez projekt przygotowawczy z lekcji 15.

## Środowiska

| Środowisko | VPC CIDR      | Typ instancji | Klucz stanu w S3                | Wdrożenie w kursie               |
|------------|---------------|---------------|---------------------------------|----------------------------------|
| dev        | 10.170.0.0/16 | t3.micro      | lesson17/dev/terraform.tfstate  | plan i wdrożenie                 |
| test       | 10.180.0.0/16 | t3.small      | lesson17/test/terraform.tfstate | plan; wdrożone tylko w lekcji 17 |
| prod       | 10.190.0.0/16 | t3.medium     | lesson17/prod/terraform.tfstate | tylko plan                       |

Klucz wskazuje ścieżkę obiektu w kubełku S3 skonfigurowanym w "backend.tf" danego środowiska.
Sam "backend.tf" nie zawiera danych stanu.

## Bezpieczny sposób pracy

1. Przejdź do katalogu wybranego środowiska.
2. Uruchom "aws sts get-caller-identity" i porównaj konto z "terraform.tfvars".
3. Uruchom "terraform init".
4. Uruchom "terraform validate" oraz "terraform test".
5. Utwórz i dokładnie przeczytaj plan.
6. Apply wykonuj tylko dla środowiska, do którego masz jawne uprawnienie.

W ramach kursu nie wykonujemy "terraform apply" w katalogu prod.

## Zasady środowisk

W środowisku prod "ssh_cidr_blocks" nie może zawierać "0.0.0.0/0".
Oznaczałoby to dopuszczenie prób połączenia SSH z całego Internetu.
Ta reguła zostanie również zapisana jako automatyczny test.

## Dane wrażliwe

Klucze AWS, tokeny i prywatne klucze SSH nie mogą trafić do plików wersjonowanych.
Pliki "terraform.tfvars" w tym repozytorium zawierają wyłącznie niesekretne wartości środowisk.

## Dokumentacja

Kontrola README modułu network:

    terraform-docs -c .\.terraform-docs.yml --output-check .\modules\network

Regenerowanie sekcji:

    terraform-docs -c .\.terraform-docs.yml .\modules\network

Oba polecenia uruchamiamy z korzenia projektu.

## Koszty i sprzątanie

Plan nie tworzy zasobów, ale jego zastosowanie może generować koszt.
Po ćwiczeniu zniszcz wdrożone środowisko.
Następnie, nadal w katalogu właśnie zniszczonego środowiska, uruchom "terraform state list" i potwierdź, że polecenie nie pokazuje żadnych adresów.
Wynik dotyczy zdalnego stanu wskazanego przez "backend.tf" tego katalogu, a nie wszystkich zasobów na koncie AWS.
Kubełek backendu pozostaje.
Może w nim pozostać plik stanu opisujący, że dane środowisko nie zarządza już żadnymi zasobami, a przy włączonym wersjonowaniu również jego wcześniejsze wersje.