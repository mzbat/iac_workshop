resource "digitalocean_droplet" "puppet-master" {
  image = "ubuntu-14-04-x64"
  name = "nightshade"
  region = "ams3"
  size = "512mb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  connection {
    user = "root"
    type = "ssh"
    # eval `ssh-agent -s` ; ssh-add ~/.ssh/id_dsa
    #agent = false
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      #"sudo apt-get -y install nginx"
    ]
  }
}
