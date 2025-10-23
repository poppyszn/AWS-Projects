module "dynamodb" {
  source = "./modules/dynamodb"
}

module "shorten_url" {
  source = "./modules/lambda"

  function_name = "shorten_url"
  handler = "shorten_url.lambda_handler"
  runtime = "python3.12"
  source_path = "./src/shorten"
  dynamodb_arn = module.dynamodb.dynamodb_arn
  api_gateway_url = module.api_gateway.api_url
  dynamodb_table_name = module.dynamodb.table_name
}

module "redirect_url" {
  source = "./modules/lambda"

  function_name = "redirect_url"
  handler = "redirect_url.lambda_handler"
  runtime = "python3.12"
  source_path = "./src/redirect"
  dynamodb_arn = module.dynamodb.dynamodb_arn
  api_gateway_url = module.api_gateway.api_url
  dynamodb_table_name = module.dynamodb.table_name
}

module "api_gateway" {
  source = "./modules/api-gw"

  lambda_shorten_function_invoke_arn = module.shorten_url.invoke_arn
  lambda_redirect_function_invoke_arn = module.redirect_url.invoke_arn
}

module "iam" {
  source = "./modules/iam"

  lambda_redirect_url_function_name = module.redirect_url.function_name
  lambda_shorten_url_function_name = module.shorten_url.function_name
  url_api_execution_arn = module.api_gateway.url_api_execution_arn
}