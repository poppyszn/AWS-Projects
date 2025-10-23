output "url_api_execution_arn" {
  value = aws_apigatewayv2_api.url_shortener_api.execution_arn
}

output "api_url" {
  value = aws_apigatewayv2_api.url_shortener_api.api_endpoint
}
