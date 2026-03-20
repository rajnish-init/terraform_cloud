resource "aws_s3_bucket" "example" {
  bucket = tfc-demo-staging-bucket-02

  tags = merge(local.common_tags, {
    Name = "S3 Bucket - ${var.bucket_name}"
  })
}