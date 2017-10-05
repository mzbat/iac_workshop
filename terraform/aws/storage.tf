resource "aws_ebs_volume" "patch" {
  count             = "1"
  # The AZ where the EBS volume exists.
  availability_zone = "${var.availability_zone}"
  # The size of the drive in GiBs.
  size              = 50
  type              = "gp2"
  tags {
    Name = "stems-patch-terra-storage"
  }
}

resource "aws_volume_attachment" "ebs_stems_patch" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.patch.0.id}"
  instance_id = "${aws_instance.stems-patch-terra.id}"
}
