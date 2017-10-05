provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_key_pair" "franklin" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

resource "aws_instance" "franklin-iac" {
  connection {
    user        = "centos"
    timeout     = "1m"
    agent       = true
  }
  ami           = "ami-d2c924b2"
  instance_type = "t2.medium"
  key_name      = "${var.key_name}"
  # comma separated list of groups
  vpc_security_group_ids = ["${var.sec_grp}"]
  #subnet_id = "${aws_subnet.stems_subnet.id}"
  associate_public_ip_address = true
  tags {
    Name = "franklin-iac"
  }
  provisioner "file" {
    source      = "conf/provision.sh"
    destination = "/home/centos/provision.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo yum update -y",
      "sudo hostnamectl set-hostname franklin --static",
      "sudo /bin/bash /home/centos/provision.sh",
      "sudo aws --no-sign-request s3 sync --exclude \".git/*\" s3://repo/puppet/ /etc/puppetlabs/"
      #"sudo /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp"
    ]
  }
}

output "sensor_ip" {
  value = "Now go add the IP ~/.ssh/id_rsa -l centos ${aws_instance.franklin-iac.public_ip}"
}
