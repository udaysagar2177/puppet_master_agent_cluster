#!/bin/bash

sudo apt-get install -yq puppet
sudo apt-get update -yq && sudo apt-get upgrade -yq
sudo puppet resource cron puppet-agent ensure=present user=root minute=5 \
        command='/usr/bin/puppet agent --onetime --no-daemonize --splay'
sudo puppet resource service puppet ensure=running enable=true

# Configure /etc/hosts file
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.128.4.189   master1204demo.example.com  master1204demo" | sudo tee --append /etc/hosts 2> /dev/null 

# Add agent section to /etc/puppet/puppet.conf
    echo "" && echo "[agent]\nserver=master1204demo.example.com" | sudo tee --append /etc/puppet/puppet.conf 2> /dev/null

sudo puppet agent --enable
