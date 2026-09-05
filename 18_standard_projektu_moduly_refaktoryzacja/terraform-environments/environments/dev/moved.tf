moved {
  from = module.security_group.aws_vpc_security_group_ingress_rule.ssh
  to   = module.security_group.aws_vpc_security_group_ingress_rule.ssh["0.0.0.0/0"]
}

moved {
  from = module.security_group.aws_vpc_security_group_ingress_rule.http
  to   = module.security_group.aws_vpc_security_group_ingress_rule.http["0.0.0.0/0"]
}