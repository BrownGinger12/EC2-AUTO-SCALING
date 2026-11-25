resource "github_repository_environment" "environments" {
  for_each = local.ci_environments

  repository  = var.github_repository_name
  environment = each.key
}

resource "github_actions_environment_variable" "tf_state_bucket" {
  for_each = local.ci_environments

  repository    = var.github_repository_name
  environment   = each.key
  variable_name = "TF_STATE_BUCKET"
  value         = aws_s3_bucket.tf_state.bucket

  depends_on = [
    github_repository_environment.environments
  ]
}

resource "github_actions_environment_variable" "aws_role_arn" {
  for_each = local.ci_environments

  repository    = var.github_repository_name
  environment   = each.key
  variable_name = "AWS_ROLE_ARN"
  value         = aws_iam_role.github_actions[each.key].arn

  depends_on = [
    github_repository_environment.environments
  ]
}