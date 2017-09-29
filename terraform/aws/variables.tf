variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default = "us-west-2"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-west-2 = "ami-d2c924b2" 
    }
}

variable "vpc-fullcidr" {
  default = "172.16.0.0/16"
  description = "vpc cdir"
}

variable "key_name" {
  default = "franklin"
  description = "Name of your SSH key in EC2"
}

# You can update this to match your personal public SSH key half.
variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAx1h+XE/b0xLyPTXbsStgvmHnYPxTIMVe4gVcnpuQBwf3j0OtCxmR8Pm9OCe83QgsWUN9q4593uFJEE+yXki5d0VCJFRbvMOEoGPLin9W2VghoJj616c5VxEIWUJlhBgFVGCtQ3YIp/O2KQ4GdKtaZdoae3hSZ9brGXZAhaxf8pmLxANmlMQO99GMD0BTW6uEUPM0Qsd1TnDCKz0RYpEjHhdSwcXro0OpATRM+Fl2W5BM0icKnmF/QnulwvwON+2FHwMy8HLkHuJd2MWmr8GD0axnogUdatVJnvTaqOc0tjM+NAuYwCm+IdAnTomDNXq31oazzsH8E6VUzx9x18dEiQ== fdiaz@exacttartget.com"
  description = "SSH Public key half to use for centos on the new stems host"
}

variable "key_path" {
  default = "/home/thedevilsvoice/.ssh/id_rsa"
  description = "Path to your SSH private key half on local dev machine"
}

variable use_public_ip { 
  default = true 
}

