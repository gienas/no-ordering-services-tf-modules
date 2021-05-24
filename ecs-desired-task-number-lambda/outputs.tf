##############

output "desired_task_number_lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.desired_task_lambda.arn
}

output "desired_task_number_lambda_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.desired_task_lambda.function_name
}
