resource "digitalocean_firewall" "puppet" {
  name = "only-22-and-8140"

  droplet_ids = ["${digitalocean_droplet.puppet-master.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["192.168.1.0/24", "2002:1:2::/48"]
    },
    {
      protocol           = "tcp"
      port_range         = "8140"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]

  # not really needed, just an example of outbound rule
  outbound_rule {
    protocol                = "udp"
    port_range              = "53"
    destination_addresses   = ["0.0.0.0/0", "::/0"]
  }
}
