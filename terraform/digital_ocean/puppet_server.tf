# This is a puppet master that will be used by the whole class. 
resource "digitalocean_droplet" "puppet-master" {
  # Obtain your ssh_key id number via your account.
  #  See Document https://developers.digitalocean.com/documentation/v2/#list-all-keys
  ssh_keys           = [13805615]
  image              = "ubuntu-16-04-x64"
  #image              = "debian-9-x64"
  name               = "puppet"
  region             = "ams3"
  size               = "4gb"
  private_networking = true
  backups            = false
  ipv6               = false
  #ssh_keys = [ "${var.ssh_fingerprint}" ]

  connection {
    user = "root"
    type = "ssh"
    # eval `ssh-agent -s` ; ssh-add ~/.ssh/do_terraform_rsa
    agent = false
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "file" {
    source      = "conf/config_puppet_master.sh"
    destination = "/root/config_puppet_master.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      #"echo \"${digitalocean_droplet.puppet-master.ipv4_address} puppet puppet.bitsmasher.net\" >> /etc/hosts",
      #"echo \"${digitalocean_droplet.bastion-host..ipv4_address} bastion bastion.bitsmasher.net\" >> /etc/hosts",
      "cd /tmp && curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb",
      "dpkg -i /tmp/puppetlabs-release-pc1-xenial.deb",
      "apt-get update",
      "apt-get install -y puppetserver",
      "bash /root/config_puppet_master.sh",
    ]
  }
}
