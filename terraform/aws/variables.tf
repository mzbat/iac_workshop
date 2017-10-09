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
  default = "ssh-dss AAAAB3NzaC1kc3MAAACBAPTAkyDjaJBi9jQqYvsU2Labl1+Yl4ag0iWvXq1+TngcNAkftwzxEQ+GnLubzpPOgoGkym8a02KeIy+1fP8+kHMcWAbYNGlFu3Pn3naAFgQsHhlfiQGhqXeIV2VSs7cXOtNm4JmADMY5gKPM5zOh4gJRvGSgbz86wvNEU4Vru5kpAAAAFQDCNNMyW6b/VU8PxnQg9hPeUaTTdwAAAIEAzPJqOc8M+Pv9Els347XPpJSqPUzg9vQFDVsFcFwO8ADslSl4JT/1rhRdrb9MozOT2/ro322PcZCzwYdalfCGtiaeISMflP4xKy8YcikxAaJIOfdnfmZTeBEacq7pkK3tvNpFlf2had+6WlKVEmhHk5k4gMulf2+dHcnMt9iGnJMAAACBALZNMdS+5Ow2HzgAIfXyri9btJJn4ErND0QxZxJylgkMCz9pbCNf1CKeHaqB6LlEbrXLxa8uPdqOfAfMZe+T5QT67qSVYJFdLb9OwY1oBVd6IK+odozke3QivwfjoKvmfueHZJFo+9w4OVGKlhgqIu5Yy4JBw6Yui38QInY80cSM thedevilsvoice@grimoire"
  description = "SSH Public key half to use for centos on the new host"
}

variable "key_path" {
  default = "/home/thedevilsvoice/.ssh/id_rsa"
  description = "Path to your SSH private key half on local dev machine"
}

variable use_public_ip { 
  default = true 
}

