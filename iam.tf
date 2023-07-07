resource "aws_iam_role" "startinschedule" {
  name = "scheduleRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "scheduler.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    tag-key = "start-schedule"
  }
}

resource "aws_iam_policy" "StartStopEc2Instances" {
  name        = "StartStopPolicyInstances"
  path        = "/"
  description = "Allows Amazon EventBridge to start and stop ec2 instances"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "StartStopEc2",
        "Effect" : "Allow",
        "Action" : [
          "ec2:StopInstances",
          "ec2:StartInstances"
        ],
        "Resource" : "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "sns_topic_policy_stop" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.sns_topic_shutdown.arn]
  }
}

data "aws_iam_policy_document" "sns_topic_policy_start" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.sns_topic_start.arn]
  }
}

resource "aws_sns_topic_policy" "sns_start_policy_attach" {
  arn    = aws_sns_topic.sns_topic_start.arn
  policy = data.aws_iam_policy_document.sns_topic_policy_start.json
}
resource "aws_sns_topic_policy" "sns_stop_policy_attach" {
  arn    = aws_sns_topic.sns_topic_shutdown.arn
  policy = data.aws_iam_policy_document.sns_topic_policy_stop.json
}




