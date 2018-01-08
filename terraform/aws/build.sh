#!/bin/bash
#
# Author: @theDevilsVoice
# Date: 09/08/2017
#
# Script Name: config.sh
#
# Description: Use this shell script to ensure your system
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile
#

echo " "
echo " "           

if [ ! -f /usr/local/bin/terraform ] ; then
  echo "Please install Terraform locally"
  exit 0
fi

if [ ! -f ~/.aws/credentials ] ; then
  echo "Please add your aws credentials to ~/.aws/credentials"
  exit 0
fi 

if [ ! -f terraform.tfvars ] ; then
  echo "Add aws_access_key and aws_secret_key to file terraform.tfvars"
  exit 0
fi

terraform plan -out plan
terraform apply "plan"

#sudo /home/centos/conf_centos.sh
#"sudo aws --no-sign-request s3 sync --exclude \".git/*\" s3://repo/puppet/ /etc/puppetlabs/"
#"sudo /opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp"

