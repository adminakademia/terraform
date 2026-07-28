resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = var.user_data

  root_block_device {
    volume_size = var.root_volume_size # <- NOWOSC: rozmiar dysku z nowej zmiennej
    volume_type = "gp3"
  }

  tags = merge(var.tags, {
    Name = var.name
  })
}