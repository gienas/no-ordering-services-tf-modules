# Task role assume policy
data "aws_iam_policy_document" "task_assume" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com", "events.amazonaws.com"]
    }
  }
}

# Task logging privileges
data "aws_iam_policy_document" "task_permissions" {
  statement {
    effect = "Allow"

    resources = [
      var.log_group_arn
    ]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

data "aws_iam_policy_document" "run_ecs_task" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "iam:PassRole"
    ]
  }
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ecs:RunTask"
    ]
  }
}
