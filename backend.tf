terraform {
  backend "s3" {
    bucket         = "ferat-terraform-backend-state"
    key            = "terraform-project/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
