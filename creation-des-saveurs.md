openstack flavor create --public m1.extra_tiny --id 1 --ram 256 --disk 2 --vcpus 1
openstack flavor create --public m1.tiny --id 2 --ram 512 --disk 4 --vcpus 1
openstack flavor create --public m1.small --id 3 --ram 1024 --disk 10 --vcpus 1
openstack flavor create --public m1.medium --id 4 --ram 2048 --disk 20 --vcpus 2
openstack flavor create --public m1.large --id 5 --ram 4096 --disk 40 --vcpus 4
openstack flavor create --public m1.xlarge --id 6 --ram 8192 --disk 100 --vcpus 6

openstack flavor list

openstack flavor delete XXX
