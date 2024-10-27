locals {
  all_bucket_names = concat([var.domain], var.subdomain_redirects)
}

data "aws_iam_policy_document" "bucket_policy" {
  for_each = toset(local.all_bucket_names)

  statement {
    sid       = "S3${each.value}StaticWebsiteAccess"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.www[each.value].arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "main" {
  bucket = var.domain

  tags = {
    Name   = var.domain
    Module = "github.com/gwojtak/tf-module-static-site"
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.s3_bucket_policy[each.value].json
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = var.index_document
  }

  dynamic "error_document" {
    for_each = toset([var.error_document])

    content {
      key = each.value
    }
  }
}
