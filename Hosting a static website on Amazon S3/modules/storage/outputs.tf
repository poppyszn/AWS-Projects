output "s3-endpoint" {
  value = aws_s3_bucket_website_configuration.domain-bucket.website_endpoint
}

output "logging-bucket-arn" {
  value = aws_s3_bucket.logging-bucket.arn
}

output "logging-bucket-name" {
  value = aws_s3_bucket.logging-bucket.bucket
}

output "sub-domain-bucket-arn" {
  value = aws_s3_bucket.sub-domain-bucket.arn
}

output "sub-domain-bucket-name" {
  value = aws_s3_bucket.sub-domain-bucket.bucket
}

output "sub-domain-bucket-hosted-zone-id" {
  value = aws_s3_bucket.sub-domain-bucket.hosted_zone_id
}

output "sub-domain-bucket-website-endpoint" {
  value = aws_s3_bucket_website_configuration.sub-domain-bucket.website_endpoint
}

output "domain-bucket-arn" {
  value = aws_s3_bucket.domain-bucket.arn
}

output "domain-bucket-name" {
  value = aws_s3_bucket.domain-bucket.bucket
}

output "domain-bucket-website-endpoint" {
  value = aws_s3_bucket_website_configuration.domain-bucket.website_endpoint
}

output "domain-bucket-hosted-zone-id" {
  value = aws_s3_bucket.domain-bucket.hosted_zone_id
}

output "domain-bucket-id" {
  value = aws_s3_bucket.domain-bucket.id
}