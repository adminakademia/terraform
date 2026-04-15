resource "aws_key_pair" "jaroslaw_aws_ec2" {
  key_name   = "jaroslaw-aws-ec2"
  public_key = file("${path.module}/testowyklucz.pub")
}

resource "aws_key_pair" "jaroslaw_aws_ec2_eu-central-1" {
  provider   = aws.eu-central-1
  key_name   = "jaroslaw-aws-ec2"
  public_key = file("${path.module}/testowyklucz.pub")
}

resource "aws_key_pair" "jaroslaw_aws_ec2_eu-west-2" {
  provider   = aws.eu-west-2
  key_name   = "jaroslaw-aws-ec2"
  public_key = file("${path.module}/testowyklucz.pub")
}