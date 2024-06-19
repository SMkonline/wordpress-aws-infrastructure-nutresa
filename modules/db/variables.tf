variable "OU" {
  description = "Organizational Unit"
  type        = string
}

variable "provider_id" {
  description = "Provider ID"
  type        = string
}

variable "stage" {
  description = "Stage (e.g., dev, prod)"
  type        = string
}

variable "instance_class" {
  description = "DB Instance Class"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}
