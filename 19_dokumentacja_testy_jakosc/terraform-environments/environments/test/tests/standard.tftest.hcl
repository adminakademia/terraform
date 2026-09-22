run "standard_srodowiska" {
  command = plan

  assert {
    condition     = local.name_prefix == "${var.project_name}-${var.environment}"
    error_message = "Prefiks nazwy musi skladac sie z nazwy projektu i srodowiska."
  }

  assert {
    condition = var.vpc_cidr_block == lookup({
      dev  = "10.170.0.0/16"
      test = "10.180.0.0/16"
      prod = "10.190.0.0/16"
    }, var.environment, "")
    error_message = "Srodowisko ma nieprawidlowa pule VPC."
  }

  assert {
    condition = var.public_subnet_cidr_block == lookup({
      dev  = "10.170.1.0/24"
      test = "10.180.1.0/24"
      prod = "10.190.1.0/24"
    }, var.environment, "")
    error_message = "Srodowisko ma nieprawidlowa pule publicznej podsieci."
  }

  assert {
    condition = var.instance_type == lookup({
      dev  = "t3.micro"
      test = "t3.small"
      prod = "t3.medium"
    }, var.environment, "")
    error_message = "Typ instancji nie odpowiada standardowi tego srodowiska."
  }

  assert {
    condition     = module.network.vpc_cidr_block == var.vpc_cidr_block
    error_message = "Modul network nie otrzymal puli VPC biezacego srodowiska."
  }

  assert {
    condition     = local.common_tags["Environment"] == var.environment
    error_message = "Tag Environment nie odpowiada nazwie srodowiska."
  }

  assert {
    condition = (
      var.environment != "prod" ||
      !contains(var.ssh_cidr_blocks, "0.0.0.0/0")
    )
    error_message = "Produkcja nie moze dopuszczac SSH z calego Internetu."
  }

  assert {
    condition     = var.root_volume_size_gib >= 8 && var.root_volume_size_gib <= 100
    error_message = "Polityka kursowego projektu dopuszcza glowny dysk od 8 do 100 GiB."
  }
}

run "odrzuca_niedozwolony_typ_instancji" {
  command = plan

  variables {
    instance_type = "m5.4xlarge"
  }

  expect_failures = [
    var.instance_type
  ]
}
