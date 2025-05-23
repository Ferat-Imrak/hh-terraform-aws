# Create a CloudWatch Log Group to store logs
resource "aws_cloudwatch_log_group" "logs" {
  name              = "/aws/monitoring"
  retention_in_days = 14
}

# Define an S3 bucket policy for CloudTrail to write logs to the S3 bucket
resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AWSCloudTrailWrite"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:PutObject"
        Resource  = "arn:aws:s3:::${var.bucket_name}/AWSLogs/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid       = "AWSCloudTrailValidate"
        Effect    = "Allow"
        Principal = { Service = "cloudtrail.amazonaws.com" }
        Action    = "s3:GetBucketAcl"
        Resource  = "arn:aws:s3:::${var.bucket_name}"
      }
    ]
  })
}

# Create a CloudTrail to log API activity and events
resource "aws_cloudtrail" "trail" {
  name                          = "cloudtrail-log"
  s3_bucket_name                = var.bucket_name
  include_global_service_events = true
}
