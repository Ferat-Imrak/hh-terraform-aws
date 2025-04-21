# Define the AWS region where resources will be deployed
variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "us-east-1" # Default region is set to us-east-1
}

# Define the user data script to configure EC2 instances
variable "user_data" {
  description = "User data script to run on EC2 instance"
  type        = string
  default     = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  echo "<html><h1>Hello, World!</h1></html>" > /var/www/html/index.html
EOF
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnets"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnets"
  type        = string
  default     = "10.0.0.0/24"
}
