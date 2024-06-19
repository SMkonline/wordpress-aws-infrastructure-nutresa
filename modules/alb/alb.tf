resource "aws_lb" "alb" {
  name               = format("%s-%s-%s-%s-%s", var.provider_id, "alb", "${var.OU}${var.stage}", "ec2", "wordpress")
  load_balancer_type = "application"
  internal           = false
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_id, var.private_subnet_id]
}

resource "aws_alb_target_group" "target_group" {
  name     = format("%s-%s-%s-%s-%s", var.provider_id, "tg", "${var.OU}${var.stage}", "ec2", "wordpress")
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 60
    matcher             = "200"
  }
}

resource "aws_alb_listener" "ec2_alb_http_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_alb_target_group.target_group]

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}