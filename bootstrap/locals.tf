locals {
  repository = "${var.github_owner}@${data.github_user.owner.id}/${var.github_repository_name}@${data.github_repository.repo.repo_id}"

  ci_environments = {
    dev = {
      subjects = [
        "repo:${local.repository}:environment:dev",
        "repo:${local.repository}:pull_request",
      ]
    }
    prod = {
      subjects = [
        "repo:${local.repository}:environment:prod",
        "repo:${local.repository}:pull_request",
      ]
    }
  }

  github_oidc_arn = var.create_github_oidc_provider ? aws_iam_openid_connect_provider.github[0].arn : data.aws_iam_openid_connect_provider.github[0].arn
  state_bucket_principals = concat(
    var.admin_principal_arns,
    [for role in aws_iam_role.github_actions : role.arn],
  )
}