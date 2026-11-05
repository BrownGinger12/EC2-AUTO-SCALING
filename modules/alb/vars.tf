variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "asg_sg_id" {
  description = "Security group ID for the EC2 instances"
  type        = string
}