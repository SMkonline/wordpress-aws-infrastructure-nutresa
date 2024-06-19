resource "aws_security_group" "load_balancer" {
  name        = format("%s-%s-%s-%s-%s", var.provider_id, "sg", var.OU, var.stage, "alb")
  description = "Controls access to the ALB ${var.OU}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = format("%s-%s-%s-%s-%s", var.provider_id, "sg", var.OU, var.stage, "ec2")
  description = "Security group for EC2 ${var.OU}"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer.id]
  }
}