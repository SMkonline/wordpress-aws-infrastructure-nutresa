resource "aws_internet_gateway" "gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = format("%s-%s-%s-%s-%s-%s", var.provider_id, "igw", "vpc", var.OU, "ppal", var.stage)
  }
}