provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

resource "aws_key_pair" "franklin" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

#resource "aws_vpc" "main" {
#  cidr_block       = "${var.vpc-fullcidr}"
  #instance_tenancy = "dedicated"
#  tags {
#    Name = "terraform-patch-franklin"
#  }
#}

output "patch_ip" {
  value = "Log in as centos \nssh -i ~/.ssh/id_rsa -l centos ${aws_instance.franklin.public_ip}"
}
