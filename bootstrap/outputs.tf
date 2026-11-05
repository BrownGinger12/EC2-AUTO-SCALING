output "state_bucket" {
  description = "Set this as the TF_STATE_BUCKET repository variable in GitHub"
  value       = aws_s3_bucket.tf_state.id
}

output "github_actions_role_arns" {
  description = "Set these as the AWS_ROLE_ARN_DEV / AWS_ROLE_ARN_PROD repository variables"
  value       = { for env, role in aws_iam_role.github_actions : env => role.arn }
}
