output "s3_bucket_name" {
  value = module.s3_bucket.s3_bucket_id
  description = "S3 bucket name"
}