variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "name" {
  type    = string
  default = "web"
}

variable "instance_names" {
  type    = list(string)
  default = ["instance-1", "instance-2", "instance-3"]
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "network_name" {
  description = "Name of the network module"
  type        = string
  default     = "web"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}