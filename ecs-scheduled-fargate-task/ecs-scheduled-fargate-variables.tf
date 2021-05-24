variable "cluster_arn" {
  description = "Cluster ARN"
  type        = string
}

variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}

variable "task_execution_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the task execution role."
  type        = string
}

variable "task_definition_cpu" {
  description = "Amount of CPU to reserve for the task."
  default     = 256
  type        = number
}

variable "task_definition_memory" {
  description = "The soft limit (in MiB) of memory to reserve for the container."
  default     = 512
  type        = number
}

variable "container_name" {
  description = "Optional name for the container to be used instead of name_prefix. Useful when when constructing an imagedefinitons.json file for continuous deployment using Codepipeline."
  default     = ""
  type        = string
}

variable "task_container_image" {
  description = "The image used to start a container."
  type        = string
}

variable "task_count" {
  description = "The number of task should be started after scheduled invocation."
  default     = 1
  type        = number
}

variable "log_group_arn" {
  description = "Log group arn"
  type        = string
}

variable "log_group_name" {
  description = "The name of the Cloudwatch log group."
  type        = string
}

variable "stop_timeout" {
  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own. On Fargate the maximum value is 120 seconds."
  default     = 30
}

variable "task_container_command" {
  description = "The command that is passed to the container."
  default     = []
  type        = list(string)
}

variable "task_container_environment" {
  description = "The environment variables to pass to a container."
  default     = {}
  type        = map(string)
}

variable "task_container_secrets" {
  description = "The secrets environment variables to pass to a container."
  default     = {}
  type        = map(string)
}

variable "task_schedule_expression" {
  description = "A cron pattern describing scheduled execution of task."
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
}

variable "security_groups_ids" {
  description = "Security groups IDs"
  type        = list(string)
}

variable "policy_task_role" {
  description = "A policy document for the task role. Task role has already another policy with logs:CreateLogStream, logs:PutLogEvents. This variable should be used when you need something more"
  type        = string
  default     = ""
}