resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = format("%s-%s-%s-%s-%s", var.provider_id, "vpc", "ppal", var.OU, var.stage)
  }
}