#!/bin/bash
#
# Description: Use this shell script to ensure your system 
#              is ready for the class.

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
NC='\033[0m' # No Color

# Do stuff for Debian based 
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
  echo -e "${LPURP}***** Do the Debian Setup *****${NC}"
  grep -Ei 'debian|buntu|mint' /etc/*release
  sudo apt-get install software-properties-common gnupg git \
  python-pip mlocate awscli
  echo -e "${CYAN}"

  python --version
  pip --version
  # pip install awscli --upgrade --user
  aws --version
  echo -e "${NC}"
  # BATS package for Ubuntu, not Debian
  #sudo add-apt-repository ppa:duggan/bats
  #sudo apt-get update
  #sudo apt-get install bats

fi


# Do stuff for RedHat
if [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
  echo -e "${LPURP}***** Do the REdHat setup *****${NC}"
fi 

# Do stuff for FreeBSD

# Do stuff for OPenBSD

# Do Stuff for Apple

# Check if terraform is installed
if [ -e "/usr/local/bin/terraform" ] ; then
  echo -e "${LPURP}***** Check terraform setup *****${NC}"
  echo -e "${CYAN}"
  terraform version
  echo -e "${NC}"
else
  echo "Instructions to instll terraform: "
  echo "https://www.terraform.io/intro/getting-started/install.html"
fi

