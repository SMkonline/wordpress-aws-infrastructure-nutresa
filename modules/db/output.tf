output "db_password" {
  description = "La contraseña para la base de datos Aurora."
  value       = random_password.password.result
  sensitive   = true
}