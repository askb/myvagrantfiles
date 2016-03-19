#!/bin/bash

devstackversion="devstack-kilo"

clone and build devstack directly from git
git clone -b stable/kilo https://github.com/openstack-dev/devstack.git $i{devstackversion}
cd ~/${devstackversion}

# create a stack user for building devstack - fix this
sudo bash /shared/${devstackversion}/tools/create-stack-user.sh
sudo su -l vagrant

# build devstack from shared folder
# cp -rpf /shared/${devstackversion} ~/
# cd /shared/
# tar cf - ./${devstackversion} | ( cd /home/vagrant/ && tar xvf - )
# cp /shared/local.conf ~/${devstackversion}/local.conf
#chown stack:stack ~/${devstackversion} -R
# chown vagrant:vagrant ~/${devstackversion} -R
# mkdir /opt/stack
# chmod 770 /home/vagrant/${devstackversion} -R
# chmod 770 /opt/stack -R
# chown vagrant:vagrant /opt/stack -R
# cd /home/vagrant/${devstackversion}

# copy the local.conf into the devstack folder
cp ~/local.conf ~/${devstackversion}

# Replace Host IP in the localrc
sed -i '/HOST_IP/ c HOST_IP=10.0.2.15' local.conf

# start building devstack
bash ./stack.sh

echo "Finished setting up devstack, this should give your the dashboard login"
echo "admin/demo credential in the local.conf"
