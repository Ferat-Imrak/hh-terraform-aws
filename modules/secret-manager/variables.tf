variable "secret_name" {
  description = "The name of the secret"
  type        = string
  default     = "db_credentials"
}

variable "db_username" {
  description = "The DB username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The DB password"
  type        = string
  sensitive   = true
}

