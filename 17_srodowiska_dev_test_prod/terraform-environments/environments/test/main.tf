module "network" {
  source = "../../modules/network"

  name_prefix       = local.name_prefix
  cidr_block        = var.vpc_cidr_block           # <- po lewej STARA nazwa wejscia modulu
  subnet_cidr       = var.public_subnet_cidr_block # <- po lewej STARA nazwa wejscia modulu
  availability_zone = var.availability_zone
  tags              = local.context_tags
}

module "security_group" {
  source = "../../modules/security_group"

  name_prefix      = local.name_prefix
  vpc_id           = module.network.vpc_id         # <- WPROST z modulu, bez terraform_remote_state!
  vpc_cidr         = module.network.vpc_cidr_block # <- to samo, stara nazwa wejscia
  ssh_cidr_blocks  = var.ssh_cidr_blocks
  http_cidr_blocks = ["0.0.0.0/0"]
  tags             = local.context_tags
}

module "ssh_key" {
  source = "../../modules/ssh_key"

  key_name   = "${local.name_prefix}-key"
  public_key = file("${path.root}/keys/testowyklucz.pub")
  tags       = local.context_tags
}

module "ec2_instance" {
  source = "../../modules/ec2_instance"

  name              = "${local.name_prefix}-web" # <- po lewej STARA nazwa wejscia modulu
  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security_group.security_group_id
  key_name          = module.ssh_key.key_name
  root_volume_size  = var.root_volume_size_gib # <- po lewej STARA nazwa wejscia modulu
  tags              = local.context_tags

  user_data = <<-EOF
    #cloud-config
    packages:
      - nginx
    runcmd:
      - systemctl enable --now nginx
  EOF
}