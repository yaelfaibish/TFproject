terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
#   backend "s3" {
#     bucket = "terraformdemo9517566"
#     key    = "aws-bucket-demo1.tfstate"
#     region = "us-east-2"
#   }
}


provider "aws" {
  region = "us-east-2"
}