variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default = "us-west-2"
}

variable "availability_zone" {
  description = "Availability Zone"
  default = "us-west-2c"
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
  default = "do_terra_rsa"
  description = "Name of your SSH key in EC2"
}

# You can update this to match your personal public SSH key half.
variable "public_key" {
  default="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDABuFmeNzJtKfq/BhI5okytxj9a7J+eDlUCPozZdasQyXq3DSy4pOUO3brYMSiTCUX0eQseUVXjzUO4C7OojZKZ8dONaiUrBvj8icKB137mDzq5iSAZrbdnIQdjiNZC3/DQ6W0PMHk4SZez0Z5oKikbP/l/E8zRxnfWJHXiogYogOdtqxZdx4SshDy2iPsReINFJNIwJJB0cbZB35fhxRAghSmf3MWjkPeHzLE+6fZD3HszzZ7g7ngDN1E5MRqH06tqeRDboTypOrH5CcUjergq2xwJ9/eSdbtrKY4uGG5U/6RTo0hA/kcLW9AmBsHlCvpn5YnLKhswETCkEOCsqHZ thedevilsvoice@grimoire"
  description = "SSH Public key half to use for centos on the new host"
}

variable "key_path" {
  default = "/home/thedevilsvoice/.ssh/do_terra_rsa"
  description = "Path to your SSH private key half on local dev machine"
}

variable use_public_ip { 
  default = true 
}

