# Moduł network

Moduł tworzy podstawową sieć dla pojedynczego środowiska kursowego.

## Odpowiedzialność

Moduł tworzy:

- jedno VPC,
- jedną publiczną podsieć,
- Internet Gateway,
- publiczną tablicę routingu,
- trasę IPv4 do Internetu,
- powiązanie podsieci z tablicą routingu.

## Poza zakresem

Moduł nie tworzy:

- prywatnych podsieci,
- NAT Gateway,
- wielu stref dostępności,
- połączeń między VPC,
- reguł bezpieczeństwa ani instancji EC2.

## Założenia

- Moduł obsługuje w tym projekcie adresację IPv4.
- Użytkownik jawnie przekazuje region przez konfigurację providera i strefę dostępności przez wejście modułu.
- Użytkownik odpowiada za wybór niekolidujących pul VPC i podsieci.
- Publiczna podsieć ma trasę 0.0.0.0/0 do Internet Gateway.

## Przykład użycia

    module "network" {
      source = "../../modules/network"

      name_prefix              = "kurs-terraform-dev"
      vpc_cidr_block           = "10.170.0.0/16"
      public_subnet_cidr_block = "10.170.1.0/24"
      availability_zone        = "eu-north-1a"

      tags = {
        Component = "platforma-webowa"
      }
    }

## Zmiany łamiące zgodność

Zmiana wartości poniższych wejść nie jest zwykłą korektą konfiguracji.
Terraform zaplanuje odtworzenie wskazanego zasobu, a razem z nim wszystkiego, co od niego zależy.

| Wejście                  | Skutek zmiany wartości                                                         |
|--------------------------|--------------------------------------------------------------------------------|
| vpc_cidr_block           | Przebudowa VPC, a wraz z nim podsieci, tablicy routingu i zasobów w tym VPC.   |
| public_subnet_cidr_block | Przebudowa podsieci, a wraz z nią instancji, które w niej stoją.               |
| availability_zone        | Przebudowa podsieci - podsieci nie da się przenieść między strefami w miejscu. |

Zmiana nazwy wejścia albo usunięcie wejścia psuje każde istniejące wywołanie modułu.
Dodanie nowego wejścia z wartością domyślną jest natomiast zmianą zgodną wstecznie: dotychczasowe wywołania działają bez zmian.

Przed każdą taką zmianą czytamy plan i szukamy w nim adnotacji "forces replacement".

## Interfejs techniczny

Poniższa sekcja jest generowana. Nie edytuj ręcznie zawartości pomiędzy znacznikami.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.6.0 |
| aws | >= 5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| aws | >= 5.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.default_ipv4](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| availability\_zone | Strefa dostepnosci, w ktorej ma powstac publiczna podsiec. | `string` | n/a | yes |
| name\_prefix | Prefiks uzywany w nazwach i tagach zasobow sieciowych. | `string` | n/a | yes |
| public\_subnet\_cidr\_block | Pula adresowa IPv4 publicznej podsieci, zapisana w notacji CIDR. | `string` | n/a | yes |
| vpc\_cidr\_block | Pula adresowa IPv4 dla VPC, zapisana w notacji CIDR. | `string` | n/a | yes |
| enable\_dns\_hostnames | Okresla, czy VPC ma nadawac instancjom nazwy DNS. | `bool` | `true` | no |
| tags | Dodatkowe tagi przypisywane do zasobow modulu. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| internet\_gateway\_id | ID Internet Gateway. |
| public\_route\_table\_id | ID publicznej tablicy routingu. |
| public\_subnet\_id | ID publicznej podsieci. |
| vpc\_cidr\_block | Adresacja CIDR VPC. |
| vpc\_id | ID utworzonego VPC. |
<!-- END_TF_DOCS -->
