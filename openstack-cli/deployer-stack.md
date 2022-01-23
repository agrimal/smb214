Déployer une stack en CLI
=========================

Plusieurs solutions :
+ Depuis le conteneur « utility »
+ Depuis son PC d'admin avec les outils CLI OpenStack

source openrc

Lister les stacks :
openstack stack list

openstack stack create \
  -t https://g.gg42.eu/OpenStack/SMB214/raw/branch/master/SMB214-HOT-Template.yaml \
  --parameter key-name=alban-vm-d11-fixe-2021-01-08 \
  --parameter image=debian11 \
  --parameter flavor-bastion=m1.tiny \
  --parameter flavor-rvprx=m1.small \
  --parameter flavor-db=m1.small \
  --parameter flavor-www=m1.medium \
  --parameter public-net=net-ext \
  SMB214
