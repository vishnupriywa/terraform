#!/bin/bash
apt-get install wget -y
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install puppetserver -y

sed -i.bak "4i 172.31.0.10     puppet"  /etc/hosts
sed -i.bak "5i 172.31.0.11     ubuntu-agent"  /etc/hosts

echo "*" > /etc/puppetlabs/puppet/autosign.conf
sed -i.bak '9d' /etc/default/puppetserver
sed -i.bak "6i JAVA_ARGS="-Xms512m -Xmx512m "" /etc/default/puppetserver

git clone https://github.com/vishnupriywa/puppetrepo.git

cp -rfv puppetrepo/*   /etc/puppetlabs/code/environments/production/manifests/

service puppetserver start
