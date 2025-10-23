# IAM Policy to Allow Any to GET from the domain bucket
data "aws_iam_policy_document" "public_bucket_policy" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    actions   = ["s3:GetObject"]
    resources = ["${var.domain-bucket-arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

# IAM Policy to Allow Logs to be PUT into the logging bucket
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "logging_bucket_policy" {
  statement {
    principals {
      identifiers = ["logging.s3.amazonaws.com"]
      type        = "Service"
    }
    actions   = ["s3:PutObject"]
    resources = ["${var.logging-bucket-arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

# Attach the PublicReadPolicy to the domain bucket
resource "aws_s3_bucket_policy" "public_access" {
  bucket = var.domain-bucket-name
  policy = data.aws_iam_policy_document.public_bucket_policy.json
}

# Attach policy to logging bucket
resource "aws_s3_bucket_policy" "logging" {
  bucket = var.logging-bucket-name
  policy = data.aws_iam_policy_document.logging_bucket_policy.json
}



