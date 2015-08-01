# puppet_master_agent_cluster
The scripts I have used for setting up a puppet master and 7 agent nodes.

Machines used are:
  * Ubuntu 12.04 (master) [hostname - master1204demo.example.com]
  * Ubuntu 14.04 (agent) [hostname - ubuntu1404demo.example.com]
  * Ubuntu 15.04 (agent) [hostname - ubuntu1504demo.example.com]
  * CentOS 5 (agent) [hostname - centos5demo.example.com]
  * CentOS 6 (agent) [hostname - centos6demo.example.com]
  * CentOS 7 (agent) [hostname - centos7demo.example.com]
  * Amazon Linux 2014.09 (agent) [hostname - amz201409.example.com]
  * Amazon Linux 2015.03 (agent) [hostname - amz201503.example.com]

First, **setup the hostnames** if you don’t have them for your instances using the below script
```shell
sudo su
hostname <YOUR-HOSTNAME>
echo "127.0.0.1 $(hostname)" >> /etc/hosts
```
**Install master on Ubuntu12.04**

The Amazon EC2 Ubuntu images can be found here : https://cloud-images.ubuntu.com  
Run the install_puppetmaster_on_ubuntu.sh script as root

**Install puppet agent on Ubuntu**

Run the install_puppet_on_ubuntu.sh script as root.

**Install puppet agent on CentOS**

First, install  Puppet Labs package repository on the instances  
centos 7
``` shell
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
```
centos 6
``` shell
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
```
centos 5
``` shell
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-5.noarch.rpm
```

Now, install puppet
```shell
yum install puppet
/etc/init.d/puppet restart
```

**Install puppet agent on Amazon Linux Instance**

Run the install_puppet_on_amzlinux.sh script as root.


**Connect to master**
Since, you have pointed to master inside your puppet.conf file, you can connect to it using the following command
```shell
puppet agent —test —debug
```
The above command runs puppet agent only once so that it can pull and apply the catalog for this node. To run the puppet in the background so that it can pull and update the configuration time to time, run
```shell
puppet agent
```

**Tips:**

To clean the certificate and their requests on puppet master and agent, use the following commands

For cleaning certificates and requests on amzlinux puppet agent (manual installation)
```shell
find /home/ec2-user/puppet-3.8.1/lib/puppet/ssl -name *.pem -exec rm {} \;
```
For cleaning certificates and requests on ubuntu and centos (yum installation)
```shell
find /var/lib/puppet -type f -print0 |xargs -0r rm
```
For cleaning certificates and requests on puppet master
```shell
find /var/lib/puppet/ssl -name centos5demo.example.com.pem -exec rm {} \;
```

You can change how often puppet agent requests puppet master for new catalog. You can adjust it by adding/changing the below line inside /etc/puppet/puppet.conf
```shell
runinterval=300
```
Try updating your openssl and wget versions on CentOS 5 if you face any errors.

You can find the monitoring scripts for puppet here if you want to check whether puppet agents are able to pull and apply the catalog.

On centos 7, puppet installs few softwares with CGroup permissions, so it is unable to root folders
You need it disable selinux inside /var/sysconfig/selinux
```shell
SELINUX=disabled
```
Then you need to reboot the instance.
