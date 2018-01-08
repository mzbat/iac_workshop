#
# Copy this file to one level above to create a puppet server in AWS. 
#
resource "aws_instance" "iac_puppet_server" {
  connection {
    user        = "centos"
    timeout     = "1m"
    #agent       = false
    #  this should point to YOUR SSH key 
    private_key = "${file("/home/thedevilsvoice/.ssh/do_terra_rsa")}"
  }
  # A centos image
  ami           = "ami-d2c924b2"
  # Puppet server runs Java, needs 4GB of RAM
  instance_type = "t2.medium"
  key_name      = "${var.key_name}"
  # comma separated list of groups
  vpc_security_group_ids = ["${aws_security_group.iac_sec_grp.id}"]
  subnet_id = "${aws_subnet.franklin-iac.id}"
  associate_public_ip_address = true
  tags {
    Name = "iac_puppet_server"
  }
  provisioner "file" {
    source      = "conf/conf_puppet_server.sh"
    destination = "/home/centos/conf.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm",
      "sudo yum install -y puppet-server", 
      # The hostname you set here has to be in /etc/hosts on all your
      # puppet agents.
      "sudo hostnamectl set-hostname iac-puppet-server --static",
      "sudo bash /home/centos/conf.sh",
    ]
  }
}
