variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "The subnet IDs for RDS"
  type        = list(string)
}
