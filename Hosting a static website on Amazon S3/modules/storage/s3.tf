resource "aws_s3_bucket" "domain-bucket" {
  bucket = var.domain_name

}

resource "aws_s3_bucket_website_configuration" "domain-bucket" {
  bucket = aws_s3_bucket.domain-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_logging" "domain-bucket" {
  bucket = aws_s3_bucket.domain-bucket.bucket

  target_bucket = aws_s3_bucket.logging-bucket.bucket
  target_prefix = "log/"
  target_object_key_format {
    partitioned_prefix {
      partition_date_source = "EventTime"
    }
  }
}

resource "aws_s3_bucket" "sub-domain-bucket" {
  bucket = "www.${var.domain_name}"
}

resource "aws_s3_bucket_website_configuration" "sub-domain-bucket" {
  bucket = aws_s3_bucket.sub-domain-bucket.id

  redirect_all_requests_to {
    host_name = var.domain_name
    protocol  = "http"
  }
}

resource "aws_s3_bucket" "logging-bucket" {
  bucket = "logs.${var.domain_name}"
}

# Enable Public Access for the domain bucket
resource "aws_s3_bucket_public_access_block" "domain-bucket" {
  bucket = aws_s3_bucket.domain-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index_document" {
  bucket       = aws_s3_bucket.domain-bucket.id
  key          = "index.html"
  source       = var.index_source
  content_type = "text/html"
}

resource "aws_s3_object" "error_document" {
  bucket       = aws_s3_bucket.domain-bucket.id
  key          = "404.html"
  source       = var.error_source
  content_type = "text/html"
}