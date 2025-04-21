# Create an S3 bucket with private access
resource "aws_s3_bucket" "private" {
  bucket = "private-bucket-hh-interview"
  acl    = "private"
}
