#!/bin/bash
apt-get install wget -y
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install puppet-agent -y
sed -i.bak "4i 172.31.0.10     puppet"  /etc/hosts
sed -i.bak "5i 172.31.0.11     ubuntu-agent"  /etc/hosts
hostnamectl set-hostname ubuntu-agent

# update /etc/hosts file with privates of pupper server and puppet gent like this
# vi /etc/hosts
# after after localhost
# private ip address of puppetserver      puppet
#private ip address of agent as           ubuntu-agent

# After this run below command in client node
#sudo /opt/puppetlabs/puppet/bin/puppet agent --test --server puppet
