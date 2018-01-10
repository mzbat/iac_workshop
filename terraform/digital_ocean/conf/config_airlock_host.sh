#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 12/28/2017
#
# Script Name: config_airlock_host.sh
#
# Description: Set up a host with all the tools for participants. 
#              Make it an ingress/egress for our lab environment. 
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile


#################
# set up puppet #
#################
function setup_puppet {
  systemctl stop puppet
  puppet agent --enable
  puppet agent --test
}

###############
# Set up ruby #
###############
function setup_ruby {
  echo "gem: --no-document" > ~/.gemrc
  /opt/puppetlabs/puppet/bin/gem install puppet-lint
  # unable to find this gem? 
  #/opt/puppetlabs/puppet/bin/gem install puppet-bolt
  return 0
} # //setup_ruby

# this is to stop the msgpack errors
function fix_msgpack {
  /opt/puppetlabs/puppet/bin/gem install msgpack
  sed -i '/main/a      preferred_serialization_format =  msgpack' /etc/puppetlabs/puppet/puppet.conf

  return 0

} # //fix_msgpack

# We need terraform on this host so we can provision other hosts
# from it. 
function install_terraform {
  
  wget -P /tmp https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip
  unzip /tmp/terraform_0.11.1_linux_amd64.zip
  mv /tmp/terraform /usr/local/bin
  return 0 
} # //install_terraform

function mount_data {

  apt-get -y  install udisks2
  mkfs -t ext4 /dev/sda
  udisksctl mount -b /dev/sda
  # add symlink to this thing? 
  return 0
} # //mount_data

function main { 
  setup_puppet
  setup_ruby
  fix_msgpack
  install_terraform
  /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
  apt-get -y install "build-essential"
  # could we config disks with cloud init? 
  #apt-get -y install cloud-init
  # get this one working so it auto-mounts
  #mount_data
}

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi
