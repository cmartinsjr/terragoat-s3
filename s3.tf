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
    c7n_status = "no-encryption"
    yor_trace = "ccf11b7f-e248-4980-bdb7-84ab30a83244"
    owner = "cmartinsjr_paloaltonetworks_com"
  }
  lifecycle_rule = {"abort_incomplete_multipart_upload_days": "0", "enabled": true, "id": "Testing Rule for Drift Detection", "noncurrent_version_expiration": {"days": "120"}}
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = "${local.resource_prefix.value}-data"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

