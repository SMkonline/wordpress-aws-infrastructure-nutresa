locals {
  stage        = terraform.workspace == "prod" ? "013" : "012"
  s3_origin_id = format("%s-%s-%s-%s-%s", var.region, "s3", var.OU, local.stage, "origin")
}