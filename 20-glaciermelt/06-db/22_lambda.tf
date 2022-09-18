resource aws_lambda_function opensearch_updates {
  function_name    = var.lambda_function_name
  filename         = data.archive_file.function_source.output_path
  source_code_hash = data.archive_file.function_source.output_base64sha256
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "opensearch_updates_lambda_function.handler"
  runtime          = "python3.9"
  depends_on       = [
    aws_cloudwatch_log_group.lambda_log_group,
    aws_iam_role_policy_attachment.lambda_logs,
  ]
}

variable lambda_function_name {
  default = "opensearch_updates_lambda_function"
}

data archive_file function_source {
  type        = "zip"
  source_dir  = "src"
  output_path = "opensearch_updates_lambda_function.zip"
}


resource aws_iam_role lambda {
  name               = "LambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

data aws_iam_policy_document lambda_assume {
  statement {
    effect  =   "Allow"
    actions = [ "sts:AssumeRole" ]
    principal {
      service = "lambda.amazonaws.com"
    }
  }
}


# TODO: opensearch_updates_lambda_function.py ファイルに、 handler 関数を作る


resource aws_cloudwatch_log_group lambda_log_group {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}


resource aws_iam_role_policy_attachment lambda_logs {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource aws_iam_policy lambda_logging {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

data aws_iam_policy_document lambda_policy {
  statement {
    effect    =   "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}
