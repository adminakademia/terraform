module "network" {
  source = "../../modules/network"

  name_prefix              = local.name_prefix
  vpc_cidr_block           = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  availability_zone        = var.availability_zone
  tags                     = local.context_tags
}

module "security_group" {
  source = "../../modules/security_group"

  name_prefix      = local.name_prefix
  vpc_id           = module.network.vpc_id
  vpc_cidr_block   = module.network.vpc_cidr_block
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

  instance_name               = "${local.name_prefix}-web"
  ami_id                      = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = module.network.public_subnet_id
  security_group_id           = module.security_group.security_group_id
  key_name                    = module.ssh_key.key_name
  associate_public_ip_address = true
  root_volume_size_gib        = var.root_volume_size_gib
  tags                        = local.context_tags

  user_data = <<-EOF
    #cloud-config
    packages:
      - nginx
    runcmd:
      - systemctl enable --now nginx
  EOF
}