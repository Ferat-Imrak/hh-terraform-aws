module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "my-secure-documents-bucket"
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

module "ec2" {
  source                = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  user_data             = var.user_data
  alb_target_group_arn  = module.alb.target_group_arn
}

module "asg" {
  source                = "./modules/asg"
  launch_template_id    = module.ec2.launch_template_id
  target_group_arn      = module.alb.target_group_arn
  subnet_ids            = module.vpc.public_subnet_ids
}

module "monitoring" {
  source      = "./modules/monitoring"
  bucket_name = module.s3.bucket_name
}

module "secret_manager" {
  source       = "./modules/secret_manager"
  secret_name  = "mysql-db-credentials"
  db_username  = var.db_username
  db_password  = var.db_password
}
