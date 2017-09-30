resource "digitalocean_droplet" "puppet-master" {
    image = "debian-7-0-x64"
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
