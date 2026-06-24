module "network" {
  source = "./modules/network"

  name_prefix       = local.name_prefix
  cidr_block        = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
  tags              = local.common_tags
}

module "security_group" {
  source = "./modules/security_group"

  name_prefix      = local.name_prefix
  vpc_id           = module.network.vpc_id # <- wyjście modułu network jako wejście tutaj
  ssh_cidr_blocks  = var.ssh_cidr_blocks
  http_cidr_blocks = ["0.0.0.0/0"]
  tags             = local.common_tags
}

module "ssh_key" {
  source = "./modules/ssh_key"

  key_name   = "${local.name_prefix}-key"
  public_key = file("${path.root}/keys/testowyklucz.pub") # <- odczyt pliku robimy w root
  tags       = local.common_tags
}

module "ec2_instances" {
  source   = "./modules/ec2_instance"
  for_each = var.instances

  name              = "${local.name_prefix}-${each.value.name_suffix}"
  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = each.value.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security_group.security_group_id
  key_name          = module.ssh_key.key_name
  tags              = local.common_tags

  user_data = <<-EOF
    #cloud-config
    packages:
      - nginx
    runcmd:
      - systemctl enable --now nginx
  EOF
}