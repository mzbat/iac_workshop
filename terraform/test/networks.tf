resource "aws_vpc" "workshop_vpc" {
cidr_block = "10.0.18.0/24"
}

resource "aws_subnet" "public_subnet_1" {
	vpc_id = "${aws_vpc.workshop_vpc.id}"
	availability_zone = "us-east-1a"
	cidr_block = "10.0.18.0/26"
}

resource "aws_internet_gateway" "workshop_gw" {
		vpc_id = "${aws_vpc.workshop_vpc.id}"
}

resource "aws_route_table" "workshop_route_table" {
		vpc_id = "${aws_vpc.workshop_vpc.id}"
		route {
			cidr_block = "0.0.0.0/0"
			gateway_id = "${aws_internet_gateway.workshop_gw.id}"
		}
}

resource "aws_route_table_association" "route_subnet_1" {
		subnet_id = "${aws_subnet.public_subnet_1.id}"
		route_table_id = "${aws_route_table.workshop_route_table.id}"
}

resource "aws_subnet" "public_subnet_2" {
		vpc_id = "${aws_vpc.workshop_vpc.id}"
		availability_zone = "us-east-1d"
		cidr_block = "10.0.18.64/26"
		}

resource "aws_route_table_association" "route_subnet_2" {
		subnet_id = "${aws_subnet.public_subnet_2.id}"
		route_table_id = "${aws_route_table.workshop_route_table.id}"
		}

resource "aws_security_group" "alb_sg" {
		vpc_id = "${aws_vpc.workshop_vpc.id}"

		ingress {
			from_port = 80
			to_port = 80
			protocol = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}

		egress {
			from_port = 80
			to_port = 80
			protocol = "tcp"
			cidr_blocks = ["10.0.18.0/24"]
		}
	}

resource "aws_security_group" "web_sg" {
		vpc_id = "${aws_vpc.workshop_vpc.id}"

		ingress {
			from_port = 80
			to_port = 80
			protocol = "tcp"
			security_groups = [ "${aws_security_group.alb_sg.id}" ]
		}

		egress {
			from_port = 0
			to_port = 0
			protocol = "-1"
			cidr_blocks = ["0.0.0.0/0"]
		}

		ingress {
			from_port = 22
			to_port = 22
			protocol = "tcp"
			security_groups = [ "${aws_security_group.alb_sg.id}" ]
		}
	}

	resource "aws_alb" "workshop_alb" {
  		name = "workshop-alb-kimberbat"
  		subnets = ["${aws_subnet.public_subnet_1.id}",
            	 "${aws_subnet.public_subnet_2.id}"]
  		security_groups = ["${aws_security_group.alb_sg.id}"]
	}

output "alb.dns" {
    value = "${aws_alb.workshop_alb.dns_name}"
}