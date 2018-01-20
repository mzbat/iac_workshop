#
# Copy this file to one level above to add a 10GB drive onto your
# AWS iac_node
#
resource "aws_ebs_volume" "iac" {
  count             = "1"
  # The AZ where the EBS volume exists.
  availability_zone = "${var.availability_zone}"
  # The size of the drive in GiBs.
  size              = 10
  type              = "gp2"
  tags {
    Name = "lnxdork-iac-storage"
  }
}

resource "aws_volume_attachment" "ebs_lnxdork_iac" {
  device_name  = "/dev/sdf"
  volume_id    = "${aws_ebs_volume.iac.0.id}"
  instance_id  = "${aws_instance.lnxdork-iac.id}"
  force_detach = true 
}
