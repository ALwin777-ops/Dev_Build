variable "matrix_port" {
  description = "External port for matrix dashboard"
  type        = number
  default     = 8081
}

variable "dev_port" {
  description = "External port for instant dev server"
  type        = number
  default     = 8080
}