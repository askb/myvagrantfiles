## CentOS/RHEL Kickstart files if you have a local repository or PXE server

### First install the required packages for virtualization
```
	yum groupinstall virtualization

```


### Command for creating the VM using the below kickstart files:

```
	virt-install --name server2.example.com --ram 768 -l ftp://192.168.1.15/pub/inst/
		--disk path=/var/lib/libvirt/images/server2.example.com,size=12
		-x "ks=ftp://192.168.1.15/pub/ks2_ftp.cfg ip=192.168.122.15 netmask=255.255.255.0 gateway=192.168.122.1 dns=192.168.122.1"
		--network network:default
	virt-install --name tester1.example.org --disk path=/var/lib/libvirt/images/tester1.example.org.img,size=14
		--network network:outsider -x "ks=ftp://192.168.1.15/pub/ks3_nfs.cfg"
		--ram 768 --location nfs://192.168.1.15/var/ftp/pub/rhel6

NOTE: --network network:<default|outsider|besider - the of the configured virtual network>

```

Note: kickstart cfs file can be read from either a ftp,nfs,cdrom,local FS. Following are the options for doing it in diff ways:

```
	-x ks=ftp/http://host/ks.cfg
	-x ks=nfs:host:/ks.cfg
	-x ks=cdrom:/dev/dir/ks.cfg
	-x ks=hd:/dev/dir/ks.cfg
	-x ks=file:/dev/dir/ks.cfg
```
