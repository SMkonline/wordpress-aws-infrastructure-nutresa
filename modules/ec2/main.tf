resource "aws_instance" "wp_ec2" {
  ami                         = var.ami
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = var.iam_ssm_profile
  
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id = var.subnet_id
  associate_public_ip_address = false

  tags = {
    Name = format("%s-%s-%s-%s-%s", var.provider_id, "ec2", var.OU, var.stage, "web")
  }
}