variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "OU" {
  type = string
}

variable "provider_id" {
  type = string
}

variable "stage" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

# variable "key_name" {
#   type = string
# }

# variable "kms_key_id" {
#   type = string
# }

variable "iam_ssm_profile" {
  type = string
}