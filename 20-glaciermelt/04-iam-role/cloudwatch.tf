resource aws_cloudwatch_log_resource_policy opensearch {
  policy_name     = "Opensearch"
  policy_document = data.aws_iam_policy_document.opensearch.json
}

data aws_iam_policy_document opensearch {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]
    principals {
      type        = "Service"
      identifiers = ["es.amazonaws.com"]
    }
    resources = [
      "arn:aws:logs:*"
    ]
  }
}
