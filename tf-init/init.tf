provider "aws" {
  region = "eu-west-1"
}

module "terraform-init" {
  source      = "telia-oss/terraform-init/aws"
  version     = "2.0.0"
  name_prefix = var.prefix
}

variable "prefix" {}

output "state_bucket" {
  value = module.terraform-init.bucket_id
}

output "lock_table" {
  value = module.terraform-init.table_id
}

output "encryption_key" {
  value = module.terraform-init.kms_key_arn
}
