provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

# Create a VPC to launch our instances into
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.franklin-iac.id}"
  route_table_id = "${aws_vpc.main.main_route_table_id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

# Create a subnet to launch our instances into
resource "aws_subnet" "franklin-iac" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = true
}

resource "aws_key_pair" "franklin" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

output "sensor_ip" {
  value = "Now do this: \n ssh -i ${var.key_path} -l centos ${aws_instance.franklin-iac.public_ip}"
}
