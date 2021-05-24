# CW rules for disabling scaling in
resource "aws_cloudwatch_event_rule" "disable_scale_in" {
  name                = "${var.event_rules_prefix_name}-disabling"
  schedule_expression = "cron(${var.disable_scale_in_schedule_expression})"
  tags = merge(var.common_tags, {
    purpose = "Rule for invoking ${var.lambda_name} - disabling"
  })
}

resource "aws_lambda_permission" "disable_scale_in" {
  statement_id  = "AllowExecutionFrom-${aws_cloudwatch_event_rule.disable_scale_in.name}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.disable_scale_in.arn
}

resource "aws_cloudwatch_event_target" "disable_scale_in" {
  target_id = var.lambda_name
  rule      = aws_cloudwatch_event_rule.disable_scale_in.name
  arn       = var.lambda_arn
  input     = "{\"policyNames\":\"${var.target_tracking_scaling_policy_names}\", \"disableScaleIn\":true}"
}

#CW rules for enabling scaling in
resource "aws_cloudwatch_event_rule" "enable_scale_in" {
  name                = "${var.event_rules_prefix_name}-enabling"
  schedule_expression = "cron(${var.enable_scale_in_schedule_expression})"
  tags = merge(var.common_tags, {
    purpose = "Rule for invoking ${var.lambda_name} - enabling"
  })
}

resource "aws_lambda_permission" "enable_scale_in" {
  statement_id  = "AllowExecutionFrom-${aws_cloudwatch_event_rule.enable_scale_in.name}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.enable_scale_in.arn
}

resource "aws_cloudwatch_event_target" "enable_scale_in" {
  target_id = var.lambda_name
  rule      = aws_cloudwatch_event_rule.enable_scale_in.name
  arn       = var.lambda_arn
  input     = "{\"policyNames\":\"${var.target_tracking_scaling_policy_names}\", \"disableScaleIn\":false}"
}
