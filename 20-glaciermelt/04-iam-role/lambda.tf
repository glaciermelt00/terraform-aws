/*
 * A role definition attached to a Lambda.
 */
resource aws_iam_role lambda {
  name               = "LambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

data aws_iam_policy_document lambda_assume {
  statement {
    effect  =   "Allow"
    actions = [ "sts:AssumeRole" ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
