variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default = "us-east-1"
}

variable "availability_zone" {
  description = "Availability Zone"
  default = "us-east-1c"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-2 = "ami-d2c924b2" 
    }
}

variable "vpc-fullcidr" {
  default = "172.16.0.0/16"
  description = "vpc cdir"
}

variable "key_name" {
  default = "pub_cert"
  description = "Name of your SSH key in EC2"
}

# You can update this to match your personal public SSH key half.
variable "public_key" {
  default="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4pIXmMB2oLJYbj3khLeTMFmKnB56u8xUydZUqjuyjuQMrWDhsrV0mTlz9RKLFD0TJXGsh2BlFgcLP3+sRkL34Slyknpy2R+xxr5q7P8wggmi9XK2wFpJptRiYCVdaTLdrYNPuD4U5inrMGiYPop4mO4uUCTbsUB8Re8eBe8Agx6keUTQbl8a2Azyfd9qzQBk8BrtskvJBMQDWccDrcKdqH/0AKTUrQpdi+eGBvOwbsljtXGRDYsjwgKkHA4PKx8MpGBNZHg+Xlf8El5GKP0GYiRBGu35Ag7PqQcfQtPULYlQjqA3/VScLfQgt5a6AeUQs5w3H1g2a3wqwkEKWBDcz lnxdork@sager.rubber.horse"
  description = "SSH Public key half to use for centos on the new host"
}

variable "key_path" {
  default = "/home/lnxdork/.ssh/id_rsa"
  description = "Path to your SSH private key half on local dev machine"
}

variable use_public_ip { 
  default = true 
}

