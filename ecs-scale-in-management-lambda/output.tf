output "lambda_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.scale_in_lambda.arn
}

output "lambda_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.scale_in_lambda.function_name
}