resource "aws_instance" "bastion" {
	ami = "ami-c481fad3"
	subnet_id = "${aws_subnet.public_subnet_1.id}"
	associate_public_ip_address = true
	key_name = "kimberbat"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${aws_security_group.bastion_sg.id}"]
}

resource "aws_security_group" "bastion_sg" {
		vpc_id = "${aws_vpc.workshop_vpc.id}"

		ingress {
			from_port = 8
			to_port = 0
			protocol = "icmp"
			cidr_blocks = ["0.0.0.0/0"]
		}

		ingress {
			from_port = 22
			to_port = 22
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}

		egress {
			from_port = 0
			to_port = 0
			protocol = "-1"
			cidr_blocks = ["0.0.0.0/0"]
		}
		}
