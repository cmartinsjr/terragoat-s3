resource "aws_s3_bucket_acl" "data" {
  bucket = "${local.resource_prefix.value}-data"
  acl    = "private"
}
resource "aws_s3_bucket" "data" {
  # bucket is public
  # bucket is not encrypted
  # bucket does not have access logs
  # bucket does not have versioning
  bucket = "${local.resource_prefix.value}-data"
  tags = {
    owner = "cmartinsjr_paloaltonetworks_com"
    yor_trace = "d6240d06-c35e-414a-b363-7052a999c6ee"
  }
}
resource "aws_s3_bucket_public_access_block" "data" {
  bucket = "${local.resource_prefix.value}-data"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

