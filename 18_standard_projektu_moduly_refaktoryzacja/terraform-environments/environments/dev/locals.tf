locals {
  name_prefix = "${var.project_name}-${var.environment}"

  # TAGI ORGANIZACYJNE - odpowiadaja na pytanie "czyje to i kto za to placi".
  # Trafiaja do default_tags providera, wiec dostanie je KAZDY zasob - takze ten
  # tworzony wewnatrz modulu. Zostaja w locals (a nie wprost w bloku default_tags),
  # bo dzieki temu uzywamy ich w DWOCH miejscach: w default_tags providera
  # oraz w outpucie "common_tags", ktory w lekcji 18 przepyta straznik standardu.
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
    CostCenter  = var.cost_center
  }

  # TAGI KONTEKSTOWE - odpowiadaja na pytanie "czym to jest w tym projekcie".
  # Przekazujemy je do modulow przez ich wejscie "tags".
  context_tags = {
    Component = "platforma-webowa"
  }
}