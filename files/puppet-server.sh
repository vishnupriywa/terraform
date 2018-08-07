#!/bin/bash
apt-get install wget -y
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install puppetserver -y


echo "*" > /etc/puppetlabs/puppet/autosign.conf
sed -i.bak '9d' /etc/default/puppetserver
sed -i.bak "6i JAVA_ARGS="-Xms512m -Xmx512m "" /etc/default/puppetserver

git clone https://github.com/vishnupriywa/puppetrepo.git

cp -rfv puppetrepo/*   /etc/puppetlabs/code/environments/production/manifests/

service puppetserver start

# update /etc/hosts file with privates of pupper server and puppet gent like this
# vi /etc/hosts
# after after localhost
# private ip address of puppetserver      puppet
#private ip address of agent as           ubuntu-agent 
