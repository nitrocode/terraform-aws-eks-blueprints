data "aws_iam_policy_document" "default" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]
  }
}
