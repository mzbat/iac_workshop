# This is so we can test puppet agent.
resource "digitalocean_droplet" "bastion-host" {
  ssh_keys           = [13805615]
  image              = "ubuntu-16-04-x64"
  #image              = "debian-9-x64"
  name               = "bastion"
  region             = "ams3"
  size               = "1gb"
  private_networking = true
  backups            = false
  ipv6               = false

  connection {
    user = "root"
    type = "ssh"
    # eval `ssh-agent -s` ; ssh-add ~/.ssh/do_terraform_rsa
    agent = false
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "cd /tmp && curl -O https://apt.puppetlabs.com/puppet5-release-xenial.deb",
      "dpkg -i /tmp/puppet5-release-xenial.deb",
      "apt-get update",
      "apt-get install puppet-agent -y",
      "echo \"${digitalocean_droplet.puppet-master.ipv4_address} puppet puppet.bitsmasher.net\" >> /etc/hosts",
      #"echo \"${digitalocean_droplet.bastion-host.ipv4_address} bastion bastion.bitsmasher.net\" >> /etc/hosts",
    ]
  }
}
