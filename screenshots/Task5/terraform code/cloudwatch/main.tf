############################################################
# CloudWatch Module
############################################################

locals {

  common_tags = {

    Project     = var.project_name

    Environment = var.environment

    ManagedBy   = "Terraform"

  }

}

############################################################
# SNS Topic
############################################################

resource "aws_sns_topic" "eks_alerts" {

  name = "${var.cluster_name}-alerts"

  tags = merge(

    local.common_tags,

    var.additional_tags

  )

}

############################################################
# Email Subscription
############################################################

resource "aws_sns_topic_subscription" "email" {

  topic_arn = aws_sns_topic.eks_alerts.arn

  protocol = "email"

  endpoint = var.alarm_email

}

############################################################
# CloudWatch Dashboard
############################################################

resource "aws_cloudwatch_dashboard" "eks_dashboard" {

  dashboard_name = "${var.cluster_name}-dashboard"

  dashboard_body = jsonencode({

    widgets = []

  })

}

############################################################
# CPU Alarm
############################################################

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {

  alarm_name = "${var.cluster_name}-HighCPU"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = var.cpu_threshold

  alarm_actions = [

    aws_sns_topic.eks_alerts.arn

  ]

}