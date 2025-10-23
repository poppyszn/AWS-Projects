variable "function_name" {
    description = "Name of lambda function"
    type = string
}
variable "handler" {
    description = "name of handler funtion in script"
    type = string
}
variable "runtime" {
    description = "Runtime for script"
    type = string
}
variable "source_path" {
    description = "Path to script"
    type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "api_gateway_url" {
  type = string
}

variable "dynamodb_arn" {
  type = string
}