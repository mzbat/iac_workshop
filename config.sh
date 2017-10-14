#!/bin/bash
#
# Description: Use this shell script to ensure your system 
#              is ready for the class.
# Author: 
# Date: 10/13/2017

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counter
ERROR_COUNTER=0

# Check if terraform is installed
echo -e "${LPURP}***** Check terraform setup *****${NC}"
if [ -e "/usr/local/bin/terraform" ] ; then
  echo -e "${CYAN}"
  terraform version
  echo -e "${NC}"
else
  echo -e "${YELLOW}"
  echo "Terraform not found in /usr/local/bin is it somewhere else?"
  echo "Instructions to install terraform: "
  echo "https://www.terraform.io/intro/getting-started/install.html"
  echo -e "${NC}"
  ERROR_COUNTER=$((ERROR_COUNTER+1))
fi

# Confirm AWS configuration
echo -e "${LPURP}***** Confirm AWS Configuration *****"
if [ ! -f ~/.aws/credentials ] ; then
  echo -e "${YELLOW}"
  echo "No ~/.aws/credentials found!"
  echo "Follow the steps at: http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html"
  echo ""
  echo -e "${NC}"
  ERROR_COUNTER=$((ERROR_COUNTER+1))
else 
  echo -e "${CYAN}"
  echo "AWS Configuration looking good..."
  echo -e "${NC}"
fi

echo -e "${LPURP}***** Check  for terraform.tfvars file *****${NC}"
if [ ! -f ./terraform/aws/terraform.tfvars ] ; then
  echo -e "${YELLOW}"
  echo "terraform/aws/terraform.tfvars not found!"
  echo "Amazon AWS won't work right."
  echo "The file should have two lines."
  echo ""
  echo "Example:"
  echo ""
  echo "aws_access_key = \"KLJAHSDFKJASHDLKJASHD\""
  echo "aws_secret_key = \"ljasdfjlkjasdflkjasdflkajd98345\""
  echo -e "${NC}"
  ERROR_COUNTER=$((ERROR_COUNTER+1))
fi

# Confirm digital ocean TF_VARS
echo -e "${LPURP}***** Check TF_VARS for Digital Ocean *****${NC}"
TF=`cat ~/.bashrc | grep TF_VAR | cut -d'=' -f1`
if [ ! -z "$TF" ] ; then
  echo -e "${CYAN}"
  echo "${TF}"
  echo -e "${NC}"
else
  echo -e "${YELLOW}"
  echo "Digial Ocean TF_VARS not found in .bashrc!"
  echo "Digital Ocean provisioning won't work right."
  echo ""
  echo "Be sure these are added to the end of .bashrc:"
  echo "" 
  echo "export TF_VAR_do_token="
  echo "export TF_VAR_pub_key="
  echo "export TF_VAR_pvt_key="
  echo "export TF_VAR_ssh_fingerprint="
  echo -e "${NC}"
  ERROR_COUNTER=$((ERROR_COUNTER+1))
fi

# Do stuff for Debian based 
echo -e "${LPURP}***** Check for Debian System *****${NC}"
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
  echo -e "${LPURP}***** Do the Debian Setup *****${NC}"
  grep -Ei 'debian|buntu|mint' /etc/*release
  sudo apt-get install software-properties-common gnupg git \
  python-pip mlocate awscli
  echo -e "${CYAN}"

  PYVER=`python --version`
  if [ -z "$PYVER" ] ; then
    echo "$PYVER"
  fi
  if [ -e "/usr/bin/pip" ] ; then
    pip --version
  else
    echo "Need to install pip?"
  fi
  if [ -e /usr/local/bin/aws ] ; then
    aws --version
  else
    echo "Need to install awscli"
    #pip install awscli --upgrade --user
  fi
  echo -e "${NC}"
  # BATS package for Ubuntu, not Debian
  #sudo add-apt-repository ppa:duggan/bats
  #sudo apt-get update
  #sudo apt-get install bats
else 
  echo -e "${LPURP}***** Not a Debian System *****${NC}"
fi


# Do stuff for RedHat
echo -e "${LPURP}***** Check for Redhat Type System *****${NC}"
if [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
  echo -e "${LPURP}***** Do the RedHat setup *****${NC}"
  sudo yum update -y
  sudo yum groupinstall 'Development Tools'
else 
  echo -e "${LPURP}***** Not a Redhat System *****${NC}"
fi 

# Do stuff for FreeBSD

# Do stuff for OPenBSD

# Do Stuff for Apple
echo -e "${LPURP}***** Check for Apple System *****${NC}"
if [ "$(uname)" == "Darwin" ]; then
  echo -e "${LPURP}***** Do the Setup for Mac *****${NC}"
  if [ -e "/usr/local/bin/brew" ] ; then 
    brew update
    brew upgrade
    brew install terraform
    brew install awscli
    # alternative awscli install method, requires brew
    #cd /tmp && curl -o awscli.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
    #unzip /tmp/awscli.zip
    #sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
    echo -e "${LPURP}***** Mac Setup Complete *****${NC}"
  else
    echo -e "${YELLOW}"
    echo "Install brew from here: https://brew.sh/ and run this script again."
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1)) 
  fi
else 
  echo -e "${LPURP}***** Not an Apple System *****${NC}"
fi

# Print the ERROR_COUNT
if [[ "$ERROR_COUNTER" -gt 0 ]] ; then
  echo -e "${LRED}"
  echo "Oh no, $ERROR_COUNTER errors found."
  echo "Please correct the errors and run this script again."
  echo -e "${NC}"
else 
  echo -e "${LGREEN}"
  echo "No errors. All clean and green."
  echo -e "${NC}"
fi 
