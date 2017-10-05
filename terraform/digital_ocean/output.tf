output "ip_address" {
  value = "${digitalocean_droplet.puppet-master.ipv4_address}"
}
