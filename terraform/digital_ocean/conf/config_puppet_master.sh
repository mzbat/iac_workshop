#!/bin/bash
#
# Author: @theDevilsVoice 
# Date: 10/13/2017
#
# Script Name: config.sh
#
# Description: Set up and start puppet master
#
# Run Information: 
#
# Error Log: Any output found in /path/to/logfile
#

# configure JAVA properties for puppetserver
# should we just copy in a modified file instead of so much sed
sed -e '/JAVA_ARGS/ s/^#*/#/' -i /etc/default/puppetserver
LINE='JAVA_ARGS="-Xms3g -Xmx3g -XX:MaxPermSize=256m"'
grep -qF "$LINE" /etc/default/puppetserver || echo "$LINE" >> /etc/default/puppetserver 

# Fix puppet.conf
sed '9 a  dns_alt_names=puppet,puppet.bitsmasher.net' /etc/puppetlabs/puppet/puppet.conf
sed -i '/master/a   autosign = /etc/puppetlabs/puppet/autosign.conf' /etc/puppetlabs/puppet/puppet.conf 
echo '*' > /etc/puppetlabs/puppet/autosign.conf
sed -i '/master/a   always_cache_features = true' /etc/puppetlabs/puppet/puppet.conf

# this is to stop the msgpack errors
apt-get install ruby-msgpack
#sed -i '/main/a      preferred_serialization_format =  msgpack' /etc/puppet/puppet.conf

# fix up the githubs
#git config --global color.ui true
#git config --global user.name "YOUR NAME"
#git config --global user.email "YOUR@EMAIL.com"

# Set up ruby
echo "gem: --no-document" > ~/.gemrc
# need to install ruby first
# apt-get install ruby-full -y
#gem install puppet-lint
 
# set the timezone
#timedatectl list-timezones
timedatectl set-timezone America/Indiana/Indianapolis
apt-get -y install ntp

# copy in the latest from the repo
cd /tmp && \ 
# change this to mzbat repo after building class
git clone https://github.com/theDevilsVoice/iac_workshop.git
cp -Rp /tmp/iac_workshop/puppetlabs /etc

# fire it up
echo "Starting puppetserver... please be patient"
systemctl start puppetserver
systemctl enable puppetserver
#systemctl is-active puppetserver
