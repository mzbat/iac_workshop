#
# This file has a couple outputs defined to illustrate messages and 
# displaying variables once an "apply" or "refresh" has completed. 
#
output "master" {
  value = "Log in to the master like so:\n    ssh -i ~/.ssh/do_terra_rsa -l root -A  ${digitalocean_droplet.puppet-master.ipv4_address}\n"
}

# uncomment this if you are using machine2.tf 
#output "agent" {
#  value = "Log in to the agent:\n    ssh -i ~/.ssh/do_terra_rsa -l root -A ${digitalocean_droplet.puppet-agent.ipv4_address}\n"
#}
