variable "admin_principal_arns" {
  description = "IAM users/roles that keep access to the state bucket"
  type        = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "github_repository" {
  description = "owner/repo allowed to assume the CI roles"
  type        = string
  default     = "BrownGinger12/EC2-AUTO-SCALING"
}

variable "create_github_oidc_provider" {
  description = "Create the GitHub OIDC provider. Set to false if the account already has one."
  type        = bool
  default     = true
}
