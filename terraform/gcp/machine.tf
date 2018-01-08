# https://cloudplatform.googleblog.com/2017/04/guest-post-using-Terraform-to-manage-Google-Cloud-Platform-infrastructure-as-code.html
resource "google_compute_instance" "blog" {
  name         = "default"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  disk {
    image = "debian-cloud/debian-8"
  }

  disk {
    type    = "local-ssd"
    scratch = true
  }

  network_interface {
    network = "default"
  }
}
