provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "web-lab"
      ManagedBy   = "terraform"
      Environment = var.environment
    }
  }
}