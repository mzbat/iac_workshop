resource "aws_instance" "lnxdork-iac" {
  connection {
    user        = "centos"
    timeout     = "1m"
    #agent       = false
    private_key = "${file("/home/lnxdork/.ssh/id_rsa")}"
  }
  #ami           = "ami-d2c924b2"
  #ami           = "ami-caaf84af"
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  key_name      = "${var.key_name}"
  # comma separated list of groups
  vpc_security_group_ids = ["${aws_security_group.iac_sec_grp.id}"]
  subnet_id = "${aws_subnet.lnxdork-iac.id}"
  associate_public_ip_address = true
  tags {
    Name = "lnxdork-iac"
  }
  provisioner "file" {
    source      = "conf/conf_centos.sh"
    destination = "/home/centos/conf.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm",
      "sudo yum install -y puppet-agent", 
      # we need something dynamic here so every hostname is unique
      #"sudo hostnamectl set-hostname iac-web --static",
      "sudo bash /home/centos/conf.sh",
    ]
  }
}


