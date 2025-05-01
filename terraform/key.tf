locals {
  key_name    = file(".keys/key_name")
  public_key  = file(".keys/public_key")
}

resource "aws_key_pair" "key_pair" {
  key_name   = local.key_name
  public_key = local.public_key
}