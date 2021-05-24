
variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  description = "Common tags to all resources in environment"
  type        = map(string)
}