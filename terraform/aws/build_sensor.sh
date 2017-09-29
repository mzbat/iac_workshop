#!/bin/bash
#
# Description: 
# Author:    
# Date:        Sep 8, 2017
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
  fiexit 0
