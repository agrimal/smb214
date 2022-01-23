Déployer une stack en CLI
=========================

Plusieurs solutions :
+ Depuis le conteneur « utility »
+ Depuis son PC d'admin avec les outils CLI OpenStack

source openrc

Lister les stacks :
openstack stack list

openstack stack create \
  -t https://g.gg42.eu/OpenStack/SMB214/raw/branch/master/heat/SMB214-HOT-Template.yaml \
  --parameter key-name=ma_clef \
  --parameter image=debian11 \
  --parameter flavor-bastion=z1.micro \
  --parameter flavor-rvprx=z1.small \
  --parameter flavor-db=z1.small \
  --parameter flavor-www=z1.medium \
  --parameter public-net=net-ext \
  SMB214
