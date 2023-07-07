resource "aws_cloudwatch_event_rule" "shutdown_ec2" {
  name        = "capture-ec2-shut-down"
  description = "Capture each AWS ec2 shutdown"

  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "state" : ["stopped"]
    }
  })
}

resource "aws_cloudwatch_event_target" "target_sns" {
  rule      = aws_cloudwatch_event_rule.shutdown_ec2.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.sns_topic_shutdown.arn
}

resource "aws_sns_topic" "sns_topic_shutdown" {
  name = "aws-ec2-shutdown"
}


resource "aws_sns_topic_subscription" "user_updates_sns_target" {
  topic_arn = aws_sns_topic.sns_topic_shutdown.arn
  protocol  = "email"
  endpoint  = "yaelhoury@gmail.com"
}
resource "aws_cloudwatch_event_rule" "start_ec2" {
  name        = "capture-ec2-start-up"
  description = "Capture each AWS ec2 start"

  event_pattern = jsonencode({
    "source" : ["aws.ec2"],
    "detail-type" : ["EC2 Instance State-change Notification"],
    "detail" : {
      "state" : ["running"]
    }
  })
}

resource "aws_cloudwatch_event_target" "target_sns_start" {
  rule      = aws_cloudwatch_event_rule.start_ec2.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.sns_topic_start.arn
}

resource "aws_sns_topic" "sns_topic_start" {
  name = "aws-ec2-start"
}

resource "aws_sns_topic_subscription" "user_updates_sns_target_start" {
  topic_arn = aws_sns_topic.sns_topic_start.arn
  protocol  = "email"
  endpoint  = "yaelhoury@gmail.com"
}