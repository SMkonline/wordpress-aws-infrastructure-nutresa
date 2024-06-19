variable "region" {
  description = "Region aws."
  type        = string
  default     = "us-east-1"
}

variable "OU" {
  description = "Organizacion de Nutresa"
  type        = string
  sensitive   = false
  nullable    = false
}

variable "provider_id" {
  description = "Proveedor y region de aws para Nutresa"
  type        = string
  sensitive   = false
  nullable    = false
}

variable "instance_type" {
  description = "El tipo de instancia EC2."
  type        = string
  default     = "t2.medium"
}

variable "instance_class" {
  description = "El tipo de instancia aurora."
  type        = string
  default     = "db.t3.small"
}

variable "ami" {
  description = "El ID del AMI para la instancia EC2."
  type        = string
}

# variable "key_name" {
#   description = "El nombre de la clave SSH para EC2."
#   type        = string
# }