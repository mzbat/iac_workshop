# import existing domain? 
# terraform import digitalocean_domain.default bitsmasher.net

# Create a new domain
resource "digitalocean_domain" "default" {
  name       = "bitsmasher.net"
  ip_address = "178.62.60.55"
}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "www"
  value  = "178.62.60.55"
}

# Add a record to the domain
resource "digitalocean_record" "puppet" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "puppet"
  value  = "${digitalocean_droplet.puppet-master.ipv4_address}"
}
 
# Add a record to the domain
resource "digitalocean_record" "bastion" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "bastion"
  value  = "${digitalocean_droplet.bastion-host.ipv4_address}"
}
