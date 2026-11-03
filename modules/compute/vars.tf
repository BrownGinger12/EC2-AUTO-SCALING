variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
}

variable "name" {
  type    = string
  default = "web"
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for the ALB"
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  type        = number
  default     = 2
  description = "Desired number of instances in the Auto Scaling group"
}

variable "target_group_arn" {
  description = "ARN of the target group to attach to the Auto Scaling group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
