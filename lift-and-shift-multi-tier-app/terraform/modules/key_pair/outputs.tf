output "public_key" {
  value = module.key_pair.public_key_fingerprint_sha256
  description = "Gives you a short, human-readable identifier for the public key"
}

output "private_key" {
  value = module.key_pair.private_key_pem
  description = "This is the actual private key material (in PEM format)"
  sensitive = true
}

output "key_pair_name" {
  value = module.key_pair.key_pair_name
  description = "The name of the keypair"
}