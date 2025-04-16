resource "tls_private_key" "lightsail_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_lightsail_key_pair" "lightsail_key2" {
  name       = "lamp"
  public_key = tls_private_key.lightsail_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "lamp.pem"
  content  = tls_private_key.lightsail_key.private_key_pem

}

resource "aws_lightsail_instance" "server" {
  name              = "lamp-server"
  availability_zone = "us-east-1a"
  blueprint_id      = "CentOS" # You can change this to the desired OS
  bundle_id         = "medium_1_0"
  key_pair_name     = "lamp" # Instance size (e.g., micro_2_0, small_2_0)


}

