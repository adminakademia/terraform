terraform {
  backend "s3" {
    bucket       = "tfstate-604598162949-eu-north-1"    # <- nazwa TWOJEGO kubelka (z outputu bootstrapu)
    key          = "aws_moduly/terraform.tfstate"        # <- "sciezka" do pliku stanu WEWNATRZ kubelka
    region       = "eu-north-1"                          # <- region, w ktorym lezy kubelek
    encrypt      = true                                  # <- wymus szyfrowanie zapisywanego stanu
    use_lockfile = true                                  # <- natywna blokada stanu w S3 (Terraform >= 1.11)
  }
}