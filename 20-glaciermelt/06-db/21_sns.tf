resource aws_sns_topic opensearch_updates {
  name = "opensearch-updates-topic"
}

resource aws_sns_topic_subscription opensearch_updates_lambda_target {
  topic_arn = aws_sns_topic.opensearch_updates.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.opensearch_updates.arn
}


resource aws_lambda_permission with_sns {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.opensearch_updates.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.opensearch_updates.arn
}
