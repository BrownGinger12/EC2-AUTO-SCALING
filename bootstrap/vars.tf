
variable "admin_principal_arns" {
  description = "IAM users/roles that keep access to the state bucket"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "github_token" {
  description = "GitHub personal access token with repo and admin:repo_hook permissions"
  type        = string
}

variable "github_owner" {
  description = "GitHub username or organization name"
  type        = string
  default     = "BrownGinger12"
}

variable "github_repository_name" {
  description = "GitHub repository name without the owner"
  type        = string
  default     = "EC2-AUTO-SCALING"
}

variable "create_github_oidc_provider" {
  description = "Create the GitHub OIDC provider. Set to false if the account already has one."
  type        = bool
  default     = true
}
