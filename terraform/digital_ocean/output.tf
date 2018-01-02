#
# This file has a couple outputs defined to illustrate messages and 
# displaying variables once an "apply" or "refresh" has completed. 
#
output "master" {
  value = "Log in to the master:\n    ssh -i ~/.ssh/do_terra_rsa -l root -A  ${digitalocean_droplet.puppet-master.ipv4_address}\n"
}

output "airlock" {
  value = "Log in to the airlock:\n    ssh -i ~/.ssh/do_terra_rsa -l root -A ${digitalocean_droplet.airlock-host.ipv4_address}\n"
}
