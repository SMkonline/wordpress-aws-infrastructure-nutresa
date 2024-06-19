resource "aws_subnet" "subnet_public" {
  vpc_id = var.vpc_id
  map_public_ip_on_launch = false
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = format("%s-%s-%s-%s-%s", var.provider_id, "snet", var.OU, "subpub01", var.stage)
  }
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = format("%s-%s-%s-%s-%s", var.provider_id, "snet", var.OU, "subprv01", var.stage)
  }
}