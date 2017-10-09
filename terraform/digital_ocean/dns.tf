# Create a new domain
resource "digitalocean_domain" "default" {
  name       = "puppet.bitsmasher.net"
  ip_address = "${digitalocean_droplet.puppet-master.ipv4_address}"
}

# Add a record to the domain
#resource "digitalocean_record" "puppet" {
#  domain = "${digitalocean_domain.default.name}"
#  type   = "A"
#  name   = "foobar"
#  value  = "192.168.0.11"
#}
