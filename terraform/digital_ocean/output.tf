#
# This file has a couple outputs defined to illustrate messages and 
# displaying variables once an "apply" or "refresh" has completed. 
#
output "master" {
  value = "Log in to the master:\n    ssh -i ~/.ssh/do_terra_rsa -l root -A  ${digitalocean_droplet.puppet-master.ipv4_address}\n"
}

output "bastion" {
  value = "Log in to the bastion:\n    ssh -i ~/.ssh/do_terra_rsa -l root -A ${digitalocean_droplet.bastion-host.ipv4_address}\n"
}
