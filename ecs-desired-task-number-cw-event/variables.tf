variable "desired_task_number_lambda_arn" {
  description = "The ARN of the target Lambda function"
  type        = string
}

variable "desired_task_number_lambda_name" {
  description = "The name of the target Lambda function"
  type        = string
}

variable "event_rule_name" {
  description = "The CW event rule name"
  type        = string
}

variable "schedule_expression" {
  description = "The schedule expression, can be in crontab"
  type        = string
}

variable "desired_count" {
  description = "Desired task count"
  type        = string
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "common_tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
}