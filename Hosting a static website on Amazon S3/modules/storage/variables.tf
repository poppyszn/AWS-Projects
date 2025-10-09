variable "domain_name" {
  description = "Domain name for site to be used as bucket name"
  type = string
}

variable "index_source" {
  description = "Location of index.html file"
  type = string
}

variable "error_source" {
  description = "Location of 404.html file"
  type = string
}