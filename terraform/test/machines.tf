resource "aws_instance" "stems-patch-terra" {

  connection {
    user        = "centos"
    type        = "ssh"
    timeout     = "1m"
    agent       = true
  }

  #ami                        = "ami-d2c924b2"
  ami                         = "${lookup(var.AmiLinux, var.region)}"
  instance_type               = "t2.medium"
  availability_zone           = "${var.availability_zone}"
  associate_public_ip_address = true
  #subnet_id                   = "${aws_subnet.Public.id}"
  # comma separated list of groups
  #vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}", "${var.sec_grp}", "${var.patch_sec_grp}"]
  vpc_security_group_ids      = ["${var.sec_grp}"]
  key_name                    = "${var.key_name}"

  tags {
    Name = "stems-patch-terra"
  }

  provisioner "file" {
    source      = "conf/configure_patch.sh"
    destination = "/tmp/configure_patch.sh"
  }

  provisioner "file" {
    source      = "conf/bash_profile"
    destination = "/home/centos/.bash_profile"
  }

  provisioner "file" {
    source      = "conf/motd"
    destination = "/tmp/motd"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo bash /tmp/configure_patch.sh",
      "sudo mv /tmp/motd /etc",
    ]
  }

}

