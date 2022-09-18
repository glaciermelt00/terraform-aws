/*
 * ## Description
 * Create an IAM Role for deployment.
 *
 * ## Usage:
 *
 * ```hcl
 * module "lambda_container_deploy" {
 *   source = "../../modules/iam/deploy-glaciermelt"
 * }
 * ```
 */

resource aws_iam_role this {
  name               = "DeployGlaciermeltRole"
  assume_role_policy = data.aws_iam_policy_document.this_assume_role.json
}

data aws_iam_policy_document this_assume_role {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::814937260541:root"]
    }
  }
}

resource aws_iam_policy this {
  name        = "DeployGlaciermeltPolicy"
  description = "Lambda Deploy Contaier Policy"
  policy      = data.aws_iam_policy_document.this.json
}

data aws_iam_policy_document this {
  statement {
    sid     = 1
    actions = [
      "ecr:BatchGetImage",
      "ecr:DescribeRepositories"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource aws_iam_role_policy_attachment this-1 {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
