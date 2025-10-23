resource "aws_dynamodb_table" "url_mappings" {
  name         = "UrlMappings"
  billing_mode = "PAY_PER_REQUEST"

  hash_key     = "shortCode"

  attribute {
    name = "shortCode"
    type = "S"
  }

  tags = {
    Environment = "production"
    Project     = "url-shortener"
  }
}
