locals {
  # Wspolne tagi dla wszystkich zasobow w projekcie
  common_tags = {
    Project     = "TerraformKurs"
    Owner       = "Jaroslaw"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    CostCenter  = "Lekcja9"
  }
 
  # Prefix używany dla nadawania nazw zasobom
  name_prefix = "lekcja9"
}