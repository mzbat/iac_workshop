output "public_ip" {
  value = "${google_compute_address.www.address}"
}

output "salt_ip" {
  value = "${join(" ", google_compute_instance.salt.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}


output "instance_ips" {
  value = "${join(" ", google_compute_instance.www.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
