module "network" {
  source = "../modules/network"

  name_prefix              = local.name_prefix
  vpc_cidr_block           = "10.211.0.0/16"
  public_subnet_cidr_block = "10.211.1.0/24"
  availability_zone        = "eu-north-1a"
}

module "security_group" {
  source = "../modules/security_group"

  name_prefix      = local.name_prefix
  vpc_id           = module.network.vpc_id # <- wyjscie jednego modulu jest wejsciem drugiego
  vpc_cidr_block   = module.network.vpc_cidr_block
  ssh_cidr_blocks  = ["0.0.0.0/0"]
  http_cidr_blocks = ["0.0.0.0/0"]
}
