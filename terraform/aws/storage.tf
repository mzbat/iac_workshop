resource "aws_ebs_volume" "iac" {
  count             = "1"
  # The AZ where the EBS volume exists.
  availability_zone = "${var.availability_zone}"
  # The size of the drive in GiBs.
  size              = 10
  type              = "gp2"
  tags {
    Name = "franklin-iac-storage"
  }
}

resource "aws_volume_attachment" "ebs_franklin_iac" {
  device_name  = "/dev/sdf"
  volume_id    = "${aws_ebs_volume.iac.0.id}"
  instance_id  = "${aws_instance.franklin-iac.id}"
  force_detach = true 
}
