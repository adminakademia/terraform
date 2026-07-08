module "security_group" {
  source = "../../modules/security_group"

  name_prefix      = local.name_prefix
  vpc_id           = data.terraform_remote_state.network.outputs.vpc_id         # <- z warstwy network!
  vpc_cidr         = data.terraform_remote_state.network.outputs.vpc_cidr_block # <- z warstwy network!
  ssh_cidr_blocks  = var.ssh_cidr_blocks
  http_cidr_blocks = ["0.0.0.0/0"]
  tags             = local.common_tags
}

module "ssh_key" {
  source = "../../modules/ssh_key"

  key_name   = "${local.name_prefix}-key"
  public_key = file("${path.root}/keys/testowyklucz.pub")
  tags       = local.common_tags
}

module "ec2_instance" {
  source = "../../modules/ec2_instance"

  name              = "${local.name_prefix}-web"
  ami_id            = data.aws_ami.ubuntu.id
  instance_type     = var.instance_type
  subnet_id         = data.terraform_remote_state.network.outputs.public_subnet_id # <- z warstwy network!
  security_group_id = module.security_group.security_group_id
  key_name          = module.ssh_key.key_name
  root_volume_size  = var.root_volume_size
  tags              = local.common_tags

  user_data = <<-EOF
    #cloud-config
    packages:
      - nginx
    runcmd:
      - systemctl enable --now nginx
  EOF
}
