resource "aws_lambda_permission" "allow_apigw_shorten" {
  statement_id  = "AllowAPIGatewayInvokeShorten"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_shorten_url_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.url_api_execution_arn}/*/*"
}

resource "aws_lambda_permission" "allow_apigw_redirect" {
  statement_id  = "AllowAPIGatewayInvokeRedirect"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_redirect_url_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.url_api_execution_arn}/*/*"
}

