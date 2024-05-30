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
    test = "drift"
    c7n_status = "no-encryption"
    owner = "cmartinsjr_paloaltonetworks_com"
    yor_trace = "d6240d06-c35e-414a-b363-7052a999c6ee"
  }
  lifecycle_rule {
    noncurrent_version_expiration = {"days": "120"}
    id = "Testing Rule for Drift Detection"
    enabled = true
    abort_incomplete_multipart_upload_days = 0
  }
  lifecycle_rule {
    noncurrent_version_transition = {"days": "300", "storage_class": "STANDARD_IA"}
    id = "Testing drift part 2"
    enabled = true
  }
  server_side_encryption_configuration = {"rule": {"apply_server_side_encryption_by_default": {"sse_algorithm": "AES256"}}}
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket = "${local.resource_prefix.value}-data"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

