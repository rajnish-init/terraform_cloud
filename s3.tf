resource "aws_s3_bucket" "example" {
  bucket = "tfc-cloud-test-bucket-sutra"

  tags = {
    Name        = "My bucket"
    Environment = "Staging"
  }
}