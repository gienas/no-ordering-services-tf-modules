variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "route53_zone_id" {
  description = "Route53 zone ID used for validation"
  type        = string
}

