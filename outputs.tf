output "matrix_dashboard_url" {
  value       = "http://localhost:${var.matrix_port}"
  description = "URL for the matrix dashboard"
}

output "dev_server_url" {
  value       = "http://localhost:${var.dev_port}"
  description = "URL for the instant dev server"
}