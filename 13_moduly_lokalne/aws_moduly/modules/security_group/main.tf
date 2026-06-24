resource "aws_security_group" "this" {
  name        = "${var.name_prefix}-sg"
  description = "Security Group dla ${var.name_prefix}"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = var.ssh_cidr_blocks[0]
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
  description = "SSH access"
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = var.http_cidr_blocks[0]
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
  description = "HTTP access"
}

resource "aws_vpc_security_group_egress_rule" "all_ipv4" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
  description = "Caly ruch wychodzacy IPv4"
}