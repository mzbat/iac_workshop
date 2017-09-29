provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "franklin-terra" {
  ami           = "ami-d2c924b2"
  instance_type = "t2.medium"

  provisioner "local-exec" {
    command = "echo ${aws_instance.franklin-terra.public_ip} > ip_address.txt"
  }
    tags {
        Name = "franklin-terra"
    }
}

resource "aws_key_pair" "deployer" {
  key_name   = "franklin-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAx1h+XE/b0xLyPTXbsStgvmHnYPxTIMVe4gVcnpuQBwf3j0OtCxmR8Pm9OCe83QgsWUN9q4593uFJEE+yXki5d0VCJFRbvMOEoGPLin9W2VghoJj616c5VxEIWUJlhBgFVGCtQ3YIp/O2KQ4GdKtaZdoae3hSZ9brGXZAhaxf8pmLxANmlMQO99GMD0BTW6uEUPM0Qsd1TnDCKz0RYpEjHhdSwcXro0OpATRM+FlJd2MWmr8GD0a18dEiQ== fssi@et.com"
}

variable "security_group_id" {
  type    = "string"
  default = "sg-85e7"
}

data "aws_security_group" "selected" {
  id = "${var.security_group_id}"
  name = "test-1-1"
}

resource "aws_iam_user" "u" {
  name          = "franklin"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "u" {
  user    = "${aws_iam_user.u.name}"
  pgp_key = "keybase:frankthetank"
}

output "password" {
  value = "${aws_iam_user_login_profile.u.encrypted_password}"
}
