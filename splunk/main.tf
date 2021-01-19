resource "aws_security_group_rule" "splunk" {
  security_group_id = var.security_group_id
  type              = "ingress"
  protocol          = "TCP"
  from_port         = "8088"
  to_port           = "8088"
  cidr_blocks       = var.security_group_cidr
  description       = "Splunk"
}

resource "aws_lb_target_group" "splunk" {
  name        = "${var.target_group_prefix}-splunk-tg"
  port        = 8088
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    protocol = "HTTPS"
    path     = "/services/collector/health"
  }

  tags = var.tags
}

resource "aws_lb_target_group_attachment" "sp001indexer" {
  target_group_arn  = aws_lb_target_group.splunk.arn
  target_id         = "10.87.145.59"
  port              = 8088
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "sp002indexer" {
  target_group_arn  = aws_lb_target_group.splunk.arn
  target_id         = "10.87.145.60"
  port              = 8088
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "sp003indexer" {
  target_group_arn  = aws_lb_target_group.splunk.arn
  target_id         = "10.87.145.61"
  port              = 8088
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "sp004indexer" {
  target_group_arn  = aws_lb_target_group.splunk.arn
  target_id         = "10.87.145.186"
  port              = 8088
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "sp005indexer" {
  target_group_arn  = aws_lb_target_group.splunk.arn
  target_id         = "10.87.145.187"
  port              = 8088
  availability_zone = "all"
}

resource "aws_lb_target_group_attachment" "sp006indexer" {
  target_group_arn  = aws_lb_target_group.splunk.arn
  target_id         = "10.87.145.188"
  port              = 8088
  availability_zone = "all"
}

resource "aws_lb_listener" "splunk" {
  load_balancer_arn = var.alb_arn
  port              = "8088"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.splunk.arn
  }
}
