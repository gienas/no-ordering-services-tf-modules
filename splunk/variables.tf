variable "security_group_id" {
  description = "SG id for splunk ingress rule"
  type        = string
}

variable "vpc_id" {
  description = "VPC id of ALB used for splunk"
  type        = string
}

variable "alb_arn" {
  description = "ALB ARN where splunk forward config will be applied"
  type        = string
}

variable "alb_cert_arn" {
  description = "Certificate arn to be used for listener"
  type        = string
}

variable "security_group_cidr" {
  description = "The CIDR block for the SG"
  type        = list(string)
}

variable "target_group_prefix" {
  description = "Prefix to be used for Splunk target group"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}