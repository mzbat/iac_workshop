# This is so we can test puppet agent.
resource "digitalocean_droplet" "puppet-agent" {
  ssh_keys           = [13805615]
  image              = "debian-9-x64"
  name               = "puppet-agent"
  region             = "ams3"
  size               = "512mb"
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

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "apt-get update && apt-get upgrade -y",
      "apt install puppet -y",
      "echo \"${digitalocean_droplet.puppet-master.ipv4_address} puppet puppet.bitsmasher.net\" >> /etc/hosts",
      #"sed -i \'1 i\server=puppet.bitsmasher.net\' /etc/puppet/puppet.conf",
      #"puppet agent -t",
    ]
  }
}

