variable "lambda_arn" {
  description = "The ARN of the target Lambda function"
  type        = string
}

variable "lambda_name" {
  description = "The name of the target Lambda function"
  type        = string
}

variable "event_rules_prefix_name" {
  description = "The CW event rules name prefix"
  type        = string
}


variable "disable_scale_in_schedule_expression" {
  description = "Disable scale in schedule expression"
  type        = string
}

variable "enable_scale_in_schedule_expression" {
  description = "Enable scale in schedule expression"
  type        = string
}

variable "target_tracking_scaling_policy_names" {
  description = "Target tracking scaling policy name"
  type        = string
}

variable "common_tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
}