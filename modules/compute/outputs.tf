output "autoscaling_group_id" {
  value = aws_autoscaling_group.this.id
}

output "asg_sg_id" {
  value = aws_security_group.this.id
}