provider "aws" {
  region = "ap-southeast-2"
}

provider "github" {
  owner = var.github_owner
  token = var.github_token
}