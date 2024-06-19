# module "kms" {
#   source = "./modules/kms"
# }

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source      = "./modules/s3"
  OU          = var.OU
  provider_id = var.provider_id
  stage       = local.stage
}

module "waf" {
  source      = "./modules/waf"
  OU          = var.OU
  provider_id = var.provider_id
  stage       = local.stage
}

module "vpc" {
  source      = "./modules/vpc"
  OU          = var.OU
  provider_id = var.provider_id
  stage       = local.stage
}

module "subnets" {
  source      = "./modules/subnets"
  vpc_id      = module.vpc.vpc_id
  OU          = var.OU
  provider_id = var.provider_id
  stage       = local.stage
}

module "igw" {
  source      = "./modules/igw"
  vpc_id      = module.vpc.vpc_id
  OU          = var.OU
  provider_id = var.provider_id
  stage       = local.stage
}

module "sg" {
  source      = "./modules/sg"
  vpc_id      = module.vpc.vpc_id
  OU          = var.OU
  provider_id = var.provider_id
  stage       = local.stage
  cidr_block  = module.vpc.cidr_block
}

module "ec2" {
  source            = "./modules/ec2"
  OU                = var.OU
  provider_id       = var.provider_id
  stage             = local.stage
  instance_type     = var.instance_type
  ami               = var.ami
  iam_ssm_profile   = module.iam.aws_iam_wordpress_profile
  security_group_id = module.sg.security_group_id
  subnet_id         = module.subnets.subnet_private_id
}

module "database" {
  source         = "./modules/db"
  OU             = var.OU
  provider_id    = var.provider_id
  stage          = local.stage
  instance_class = var.instance_class
  region         = var.region
}

module "alb" {
  source            = "./modules/alb"
  OU                = var.OU
  provider_id       = var.provider_id
  stage             = local.stage
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.subnets.subnet_public_id
  private_subnet_id = module.subnets.subnet_private_id
  security_group_id = module.sg.security_group_id
}

module "efs" {
  source            = "./modules/efs"
  OU                = var.OU
  provider_id       = var.provider_id
  stage             = local.stage
  security_group_id = module.sg.security_group_id
  subnet_id         = module.subnets.subnet_private_id
}