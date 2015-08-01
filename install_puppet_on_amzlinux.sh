#!/bin/bash

yum -y install redhat-lsb-core wget ruby
wget http://downloads.puppetlabs.com/facter/facter-2.4.4.tar.gz
tar xvf facter-2.4.4.tar.gz
wget https://downloads.puppetlabs.com/hiera/hiera-1.3.4.tar.gz
tar xvf hiera-1.3.4.tar.gz
wget https://downloads.puppetlabs.com/puppet/puppet-3.8.1.tar.gz
tar xvf puppet-3.8.1.tar.gz
sudo ruby facter-2.4.4/install.rb
sudo ruby hiera-1.3.4/install.rb
sudo ruby puppet-3.8.1/install.rb

cp puppet-3.8.1/ext/redhat/puppet.conf /etc/puppet/
echo "[agent]" >> /etc/puppet/puppet.conf
echo "server=master1204demo.example.com" >> /etc/puppet/puppet.conf

echo "10.128.4.189    master1204demo.example.com master1204" >> /etc/hosts
