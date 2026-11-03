variable "admin_principal_arns" {
  description = "IAM users/roles that keep access to the state bucket"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}