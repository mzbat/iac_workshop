output "puppet_master_ip" {
  value = "${digitalocean_droplet.puppet-master.ipv4_address}"
}

output "puppet_agent_ip" {
  value = "${digitalocean_droplet.puppet-agent.ipv4_address}"
}
