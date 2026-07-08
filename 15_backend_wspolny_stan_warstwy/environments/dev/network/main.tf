module "network" {
  source = "../../modules/network"

  name_prefix       = local.name_prefix
  cidr_block        = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  tags              = local.common_tags
}