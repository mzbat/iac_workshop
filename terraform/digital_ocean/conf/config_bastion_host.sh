#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 12/28/2017
#
# Script Name: config_bastion_host.sh
#
# Description: Set up and start puppet master
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile


# set up puppet
systemctl stop puppet
puppet agent --enable
puppet agent --test

# Set up ruby
echo "gem: --no-document" > ~/.gemrc
apt-get install ruby-full -y
gem install puppet-lint

# this is to stop the msgpack errors
apt-get install -y ruby-msgpack
sed -i '/main/a      preferred_serialization_format =  msgpack' /etc/puppet/puppet.conf


/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
