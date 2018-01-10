resource "digitalocean_firewall" "puppet" {
  name = "only-22-and-8140"

  droplet_ids = ["${digitalocean_droplet.puppet-master.id}"]

  # add your public IP to source addresses or no SSH for you
  # In this example, "75.15.12.240" is our public IP address. 
  inbound_rule = [
    {
      protocol            = "tcp"
      port_range          = "22"
      #source_addresses   = ["75.15.12.240", "192.168.1.0/24", "2002:1:2::/48"]
      source_addresses    = ["0.0.0.0/0"]
    },
    {
      protocol            = "tcp"
      port_range          = "80"
      source_addresses    = ["0.0.0.0/0"]
    },
    {
      protocol            = "tcp"
      port_range          = "443"
      source_addresses    = ["0.0.0.0/0"]
    },
    {
      protocol            = "tcp"
      port_range          = "8140"
      source_addresses    = ["0.0.0.0/0"]
    }
  ]

  # not really needed, just an example of outbound rule
  outbound_rule =[
    {
      protocol                = "udp"
      port_range              = "53"
      destination_addresses   = ["0.0.0.0/0"]
    },
    {
      protocol                = "tcp"
      port_range              = "80"
      destination_addresses   = ["0.0.0.0/0"]
    },
    {
      protocol                = "tcp"
      port_range              = "443"
      destination_addresses   = ["0.0.0.0/0"]
    } 
  ]
}
