variable "log_group_name" {
  description = "Log group name"
  type        = string

}

variable "sns_topic_arn" {
  description = "Arn of SNS topic for notifications"
  type        = string
}