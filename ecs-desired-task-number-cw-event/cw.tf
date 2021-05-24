resource "aws_lambda_permission" "cloudwatch" {
  statement_id  = "AllowExecutionFrom-${var.event_rule_name}"
  action        = "lambda:InvokeFunction"
  function_name = var.desired_task_number_lambda_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda.arn
}

resource "aws_cloudwatch_event_rule" "lambda" {
  name                = "${var.event_rule_name}-rule"
  schedule_expression = "cron(${var.schedule_expression})"
  tags = merge(var.common_tags, {
    purpose = "Rule for invoking desired task lambda"
  })
}

resource "aws_cloudwatch_event_target" "lambda" {
  target_id = var.desired_task_number_lambda_name
  rule      = aws_cloudwatch_event_rule.lambda.name
  arn       = var.desired_task_number_lambda_arn
  input     = "{\"desiredCount\":\"${var.desired_count}\",\"serviceName\":\"${var.service_name}\",\"clusterName\":\"${var.cluster_name}\"}"
}
