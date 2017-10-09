variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a new SSH key
#resource "digitalocean_ssh_key" "default" {
#  name       = "Terraform Example"
#  public_key = "${file("/home/thedevilsvoice/.ssh/do_terra_rsa.pub")}"
#}
