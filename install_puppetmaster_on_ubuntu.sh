wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && \
sudo dpkg -i puppetlabs-release-trusty.deb && \
sudo apt-get update -yq && sudo apt-get upgrade -yq && \
sudo apt-get install -yq puppetmaster

# Configure /etc/hosts file
echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
echo "10.128.4.189    master1204demo.example.com  master1204" | sudo tee --append /etc/hosts 2> /dev/null && \

# Add optional alternate DNS names to /etc/puppet/puppet.conf
sudo sed -i 's/.*\[main\].*/&\ndns_alt_names = master1204,master1204.example.com/' /etc/puppet/puppet.conf
