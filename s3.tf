resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = merge(local.common_tags, {
    Name = "S3 Bucket - ${var.bucket_name}"
  })
}