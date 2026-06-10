locals {
  # --- wartości z poprzedniej lekcji (zostają) ---
  common_tags = {
    Project     = "TerraformKurs"
    Owner       = "Jaroslaw"
    Environment = "Dev"
    ManagedBy   = "Terraform"
    CostCenter  = "Lekcja9"
  }
  name_prefix = "lekcja11-${terraform.workspace}"

  # --- NOWE wartości (lekcja 10) ---

  # STAŁA: oficjalne konto Canonical (wydawcy Ubuntu) w AWS (uzywane w data.tf)
  ubuntu_owner_id = "099720109477"

  # POLITYKA: dozwolone typy instancji wg budzetu projektu
  allowed_instance_types = ["t3.micro", "t3.small", "t2.micro", "t2.small"]

  # WYLICZANE: mapa AMI zbudowana dynamicznie z data sources (zastepuje var.regional_amis)
  regional_amis = {
    "eu-north-1"   = data.aws_ami.ubuntu_najnowszy.id
    "eu-central-1" = data.aws_ami.ubuntu_najnowszy_eu-central-1.id
    "eu-west-2"    = data.aws_ami.ubuntu_najnowszy_eu-west-2.id
  }

  # Lista regul wejsciowych (ingress) dla security group - steruje blokiem dynamic
   ingress_rules = concat(
    [
      { port = 22,  description = "SSH" },
      { port = 80,  description = "HTTP (nginx)" },
      { port = 443, description = "HTTPS" },
    ],
    terraform.workspace == "prod" ? [{ port = 8080, description = "App (tylko prod)" }] : []
  )

  # Wybor pliku cloud-init zaleznie od workspace (z wartoscia domyslna)
  cloud_init_file = lookup(
    {
      prod = "konf_cloud_init_prod.yaml"
    },
    terraform.workspace,
    "konf_cloud_init.yaml"
  )

}
