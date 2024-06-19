resource "aws_kms_key" "wordpress_key" {
  description             = "KMS key for encrypting WordPress resources"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

output "kms_key_id" {
  value = aws_kms_key.wordpress_key.key_id
}
