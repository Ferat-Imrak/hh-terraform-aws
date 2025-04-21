# Create a VPC with the specified CIDR block
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}

# Create an S3 bucket for storing secure documents
module "s3" {
  source = "./modules/s3"
  bucket_name = "my-secure-documents-bucket"
}

# Deploy an RDS instance in the private subnets of the VPC
module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

# Create an Application Load Balancer in the public subnets
module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

# Launch EC2 instances in the public subnets and register them with the ALB
module "ec2" {
  source                = "./modules/ec2"
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  user_data             = var.user_data
  alb_target_group_arn  = module.alb.target_group_arn
}

# Create an Auto Scaling Group and associate it with the ALB
module "asg" {
  source                = "./modules/asg"
  launch_template_id    = module.ec2.launch_template_id
  target_group_arn      = module.alb.target_group_arn
  subnet_ids            = module.vpc.public_subnet_ids
}

# Placeholder for monitoring resources (e.g., CloudWatch, alarms)
module "monitoring" {
  source      = "./modules/monitoring"
  bucket_name = module.s3.bucket_name
}