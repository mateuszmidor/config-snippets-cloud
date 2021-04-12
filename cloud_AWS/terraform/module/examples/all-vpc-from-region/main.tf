terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = {
      version = ">= 2.28.1"
    }
    kentik-cloudexport = {
      version = "0.1.0"
      source = "kentik/kentik-cloudexport"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
}

provider "kentik-cloudexport" {

}

data "aws_vpcs" "all-vpc" {}

module "kentik_aws_integration" {
  source = "../../"

  rw_s3_access = true
  vpc_id_list  = data.aws_vpcs.all-vpc.ids
  s3_bucket_prefix           = "terraform-example"
  iam_role_prefix            = "terraform-example"
  store_logs_more_frequently = true
  name                       = "example-aws-terraform-name"
  plan_id                    = "11467"
  region                     = "us-east-2"
  multiple_buckets           = true
}
