# Create a Secrets Manager secret to store database credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "db-secrets"
  description = "Credentials for MySQL RDS instance"
}

# Create a specific version of the secret with the actual credentials
resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = ""
    password = ""
  })
}
