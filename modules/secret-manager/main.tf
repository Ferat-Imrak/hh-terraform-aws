resource "aws_secretsmanager_secret" "db_credentials" {
  name        = var.secret_name
  description = "Credentials for MySQL RDS instance"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}
