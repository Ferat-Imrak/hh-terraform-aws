variable "launch_template_id" {
  description = "Launch template ID"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
