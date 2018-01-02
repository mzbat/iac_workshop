# import existing domain? 
# terraform import digitalocean_domain.default bitsmasher.net

# Create a new domain
resource "digitalocean_domain" "default" {
  name       = "bitsmasher.net"
  ip_address = "178.62.60.55"
}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "www"
  value  = "178.62.60.55"
}

# Add a record to the domain
resource "digitalocean_record" "puppet" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "puppet"
  value  = "${digitalocean_droplet.puppet-master.ipv4_address}"
}
 
# Add a record to the domain
resource "digitalocean_record" "airlock" {
  domain = "${digitalocean_domain.default.name}"
  type   = "A"
  name   = "airlock"
  value  = "${digitalocean_droplet.airlock-host.ipv4_address}"
}

resource "digitalocean_record" "txt1" {
  domain = "${digitalocean_domain.default.name}"
  type   = "TXT"
  name   = "@"
  value  = "protonmail-verification=61f4835bee8424d6668cf2384ff3da85ba5731a4",
}

resource "digitalocean_record" "mx" {
  domain    = "${digitalocean_domain.default.name}"
  type      = "MX"	
  value     = "@"
  name      = "mail.protonmail.ch"	
  priority  = "10"
}

resource "digitalocean_record" "txt2" {
  domain    = "${digitalocean_domain.default.name}"
  type      = "TXT"
  name      = "@"
  value     = "v=spf1 include:_spf.protonmail.ch mx ~all"
}

# ProtonMail supports DKIM signing for custom domains! 
resource "digitalocean_record" "dkim" {
  domain    = "${digitalocean_domain.default.name}"
  type      = "TXT"	
  name      = "protonmail._domainkey"
  value     = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCppN6zgQi+/c5XjYZveFnVtBO1g3SIiVSfR1qJLaOsN6MzNydnIzKtaR+qPCvmpz5cy5+rTY9wdyiB9CjhrCp1DjBR4ko5OKl50WF8In3po0k46dhJ5EgVk9w/NcVn0JWgr+MhcTaJh+bqysuNIXvyKYA8/aMWeakBsZ6eof2/wwIDAQAB"
}  

resource "digitalocean_record" "txt3" {
  domain    = "${digitalocean_domain.default.name}"
  type      = "TXT"	
  name      = "_dmarc"	
  value     = "v=DMARC1; p=none; rua=mailto:franklin@bitsmasher.net"
}
