provider "aws" {
  region = var.aws_region

  # BEZPIECZNIK KONTA: ten katalog wolno uruchomic WYLACZNIE na tym koncie AWS.
  # Dziala od "plan" w gore - "validate" go NIE uruchomi.
  allowed_account_ids = [var.aws_account_id]

  # TAGI ORGANIZACYJNE: doklejane do KAZDEGO zasobu tego providera,
  # takze do zasobow tworzonych WEWNATRZ modulow (dziedziczenie konfiguracji providera).
  default_tags {
    tags = local.common_tags
  }
}