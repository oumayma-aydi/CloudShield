terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:4566"
    sts = "http://localhost:4566"
  }
}

# 1. Create a VPC (Virtual Private Cloud)
# checkov:skip=CKV2_AWS_11: "Flow logs are not required for local testing"
# checkov:skip=CKV2_AWS_12: "Default SG will be managed later in the project"
resource "aws_vpc" "cloudshield_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "CloudShield-VPC"
    Environment = "DevSecOps-Project"
    Owner       = "Oumayma"
  }
}

# 2. Create a Public Subnet
# checkov:skip=CKV_AWS_130: "This subnet intentionally assigns public IPs for our web server"
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.cloudshield_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "CloudShield-Public-Subnet"
  }
}
