#!/bin/bash
apt-get install wget -y
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install puppet-agent -y
sed -i.bak "4i 172.31.0.10     puppet"  /etc/hosts
sed -i.bak "5i 172.31.0.11     ubuntu-agent"  /etc/hosts
hostnamectl set-hostname ubuntu-agent
sudo /opt/puppetlabs/puppet/bin/puppet agent --test --server puppet
