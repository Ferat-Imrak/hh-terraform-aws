resource "aws_s3_bucket" "private" {
  bucket = "private-bucket-hh-interview"
  acl    = "private"
}
