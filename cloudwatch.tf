resource "aws_cloudwatch_event_rule" "ec2-rule" {
  name        = "watch-terraform"
  description = "RunInstances-auto-tag"
   event_pattern = jsonencode({  "source": ["aws.ec2"], 
   "detail-type": ["AWS API Call via CloudTrail"], 
   "detail": {"eventSource": ["ec2.amazonaws.com"], 
   "eventName": ["RunInstances"]
   }
   }
   )
}
resource "aws_cloudwatch_event_target" "lambda-fun" {
  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.ec2-rule.name
  arn       = aws_lambda_function.test_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "terraform-lamda"
  principal     = "events.amazonaws.com"
  source_arn     = aws_cloudwatch_event_rule.ec2-rule.arn
}