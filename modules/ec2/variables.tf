variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-07a6f770277670015"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "User data script for EC2"
  type        = string
}

variable "alb_target_group_arn" {
  description = "The ARN of the ALB target group"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}