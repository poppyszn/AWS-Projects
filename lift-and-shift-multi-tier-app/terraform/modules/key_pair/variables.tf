variable "key_pair_create" {
  type        = bool
  description = "Determines whether resources will be created or not (affects all resources)"
  default     = true
}

variable "key_pair_create_private_key" {
  type        = bool
  description = "Determines whether a private key will be created or not"
  default     = true
}

variable "key_pair_key_name" {
  type        = string
  description = "The name for the key pair"
}

variable "key_pair_public_key" {
  type        = string
  description = "The public key material"
  default     = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}