module "network" {
  source = "../../../modules/network" # <- TRZY poziomy w gore

  name_prefix              = local.name_prefix
  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  availability_zone        = var.availability_zone
}