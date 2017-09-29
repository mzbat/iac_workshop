resource "aws_security_group_rule" "proxy" {
  type            = "ingress"
  from_port       = 8888 
  to_port         = 8888 
  protocol        = "tcp"
  cidr_blocks     = ["${aws_instance.franklin-iac.public_ip}/32"]
  security_group_id = ""
}

resource "aws_security_group_rule" "openvpn" {
  type            = "ingress"
  from_port       = 1194
  to_port         = 1194
  protocol        = "udp"
  cidr_blocks     = ["${aws_instance.franklin-iac.public_ip}/32"]
  security_group_id = "sg-daf"
}
