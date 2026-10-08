module "security_group" {
  source = "../../../modules/security_group"

  name_prefix      = local.name_prefix
  vpc_id           = data.terraform_remote_state.network.outputs.vpc_id         # <- z warstwy network
  vpc_cidr_block   = data.terraform_remote_state.network.outputs.vpc_cidr_block # <- z warstwy network
  ssh_cidr_blocks  = var.ssh_cidr_blocks
  http_cidr_blocks = ["0.0.0.0/0"]
}