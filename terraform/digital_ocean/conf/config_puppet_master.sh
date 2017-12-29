#!/bin/bash
#
# Description: Set up and start puppet master
# Author: Frank The Tank

# avoid conflict with apache2 
systemctl stop apache2

# JAVA_ARGS="-Xms3g -Xmx3g -XX:MaxPermSize=256m"
sed -e '/JAVA_ARGS/ s/^#*/#/' -i /etc/default/puppetserver
LINE='JAVA_ARGS="-Xms3g -Xmx3g -XX:MaxPermSize=256m"'
grep -qF "$LINE" /etc/default/puppetserver || echo "$LINE" >> /etc/default/puppetserver 
#sed '9 a  dns_alt_names=puppet,puppet.bitsmasher.net' /etc/puppetlabs/puppet/puppet.conf
#sed -i '/master/a   autosign = true' /etc/puppetlabs/puppet/puppet.conf 
#grep -q -F 'dns_alt_names=puppet,puppet.bitsmasher.net'  /etc/puppet/puppet.conf || echo 'dns_alt_names=puppet,puppet.bitsmasher.net' >> /etc/puppet/puppet.conf

#git config --global color.ui true
#git config --global user.name "YOUR NAME"
#git config --global user.email "YOUR@EMAIL.com"
echo "gem: --no-document" > ~/.gemrc
#gem install puppet-lint
 
# set the timezone
#timedatectl list-timezones
timedatectl set-timezone America/Indiana/Indianapolis
apt-get -y install ntp

systemctl start puppetserver
systemctl enable puppetserver
#systemctl is-active puppetserver
systemctl status puppetserver
