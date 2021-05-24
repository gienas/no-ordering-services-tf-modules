
variable "local_environment" {
  description = "Local name of this environment (eg, prod, stage, dev, feature1)"
  type        = string
}

variable "common_tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}
