#!/bin/bash
#
# Author: @theDevilsVoice
# Date: 09/08/2017
#
# Script Name: conf_centos.sh
#
# Description: Use this shell script to ensure your system
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile
#

# Make sure we have privs
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# 
yum install -y git 

# Configure the storage we created
mount="/mnt/data1"
if ! grep -qs "$mount" /proc/mounts; then
  mkfs -t ext4 /dev/sdf
  mkdir ${mount}
  mount /dev/sdf ${mount}
fi

# Install puppet
#http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
rpm -ivh https://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-22.0-2.noarch.rpm
yum install -y puppet

# Find the IPv4 address of puppet master
yum install -y bind-utils
PUPPET_MASTER_IP=$(/usr/bin/host puppet.bitsmasher.net | grep "has address" | head -1 | awk '{print $NF}')
if ! grep -Fxq "${PUPPET_MASTER_IP} puppet puppet.bitsmasher.net" /etc/hosts
then
  echo "${PUPPET_MASTER_IP} puppet puppet.bitsmasher.net" >> /etc/hosts
fi 

# Fix up puppet.conf
sed -i '/main/a      server=puppet' /etc/puppet/puppet.conf 
#gem install msgpack
#sed -i '/main/a      preferred_serialization_format =  msgpack' /etc/puppet/puppet.conf
systemctl restart puppet
sudo systemctl enable puppet

# This command might not work the first (or even second) time. 
# Might need to do manually
puppet agent --test 

# double check dat ufw (obsoleted by security.tf)
#ufw allow 8140
