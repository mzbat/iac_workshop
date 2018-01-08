# https://stackoverflow.com/questions/44070828/terraform-mount-volume
resource "digitalocean_volume" "class" {
  region      = "ams3"
  name        = "iac_workshop"
  size        = 2
  description = "a class volume"
}
