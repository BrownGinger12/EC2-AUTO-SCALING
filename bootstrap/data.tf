data "github_user" "owner" {
  username = var.github_owner
}

data "github_repository" "repo" {
  full_name = "${var.github_owner}/${var.github_repository_name}"
}

data "aws_iam_openid_connect_provider" "github" {
  count = var.create_github_oidc_provider ? 0 : 1

  url = "https://token.actions.githubusercontent.com"
}