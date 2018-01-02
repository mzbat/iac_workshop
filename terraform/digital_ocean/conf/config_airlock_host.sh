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


# set up puppet
function setup_puppet {
  systemctl stop puppet
  puppet agent --enable
  puppet agent --test
}

# Set up ruby
# this is part of puppet role as well, might remove
function setup_ruby {
  echo "gem: --no-document" > ~/.gemrc
  apt-get install ruby-full -y
  gem install puppet-lint
}

# this is to stop the msgpack errors
function fix_msgpack {
  #apt-get install -y ruby-msgpack
  gem install msgpack
  sed -i '/main/a      preferred_serialization_format =  msgpack' /etc/puppetlabs/puppet/puppet.conf
}

# We need terraform on this host so we can provision other hosts
# from it. 
function install_terraform {
  
  wget -P /tmp https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip
  unzip /tmp/terraform_0.11.1_linux_amd64.zip
  mv /tmp/terraform /usr/local/bin
 
}

function main { 
  setup_puppet
  setup_ruby
  fix_msgpack
  install_terraform
  /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
}

if [ -z "$ARGS" ] ; then
  main $@
else
  main $ARGS
fi
