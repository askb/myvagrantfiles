#!/bin/bash

devstackversion="devstack-liberty"

# make sure the packages are installed
# sudo apt-get udpate -y
# sudo apt-get upgrade -y
# sudo apt-get install -y virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms
# sudo apt-get install -y git
# sudo apt-get install -y wget
# sudo apt-get install -y python-pip
# sudo apt-get install -y python-dev

# clone and build devstack directly from git
# git clone -b stable/kilo https://github.com/openstack-dev/devstack.git
# devstackversion="devstack"
# cd ~/${devstackversion}

# create a stack user for building devstack - fix this
sudo bash /shared/${devstackversion}/tools/create-stack-user.sh
sudo su -l vagrant

# fixes - [ERROR] Can't find package os-testr in requirements - if pip is not upgraded
# sudo pip install --upgrade pip
# sudo pip install -U os-testr

# build devstack from share
# cp -rpf /shared/${devstackversion} ~/
cd /shared/
tar cf - ./${devstackversion} | ( cd /home/vagrant/ && tar xvf - )
cp /shared/local.conf ~/${devstackversion}/local.conf
#chown stack:stack ~/${devstackversion} -R
chown vagrant:vagrant ~/${devstackversion} -R
mkdir /opt/stack
chmod 770 /home/vagrant/${devstackversion} -R
chmod 770 /opt/stack -R
cd ~/${devstackversion}

# Replace Host IP
sed -i '/HOST_IP/ c HOST_IP=10.0.2.15' local.conf

# start building devstack
bash ./stack.sh

echo "Finished setting up devstack."
