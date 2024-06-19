resource "aws_s3_bucket" "bucket" {
  bucket = format("%s-%s-%s-%s-%s", var.provider_id, "s3", var.OU, var.stage, "web")

  tags = {
    Name = format("%s-%s-%s-%s-%s", var.provider_id, "s3", var.OU, var.stage, "web")
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket     = aws_s3_bucket.bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}