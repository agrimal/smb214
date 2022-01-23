Création des saveurs (flavors) pour les instances
=================================================

Création de saveurs de base :
```
openstack flavor create --public z1.nano   --id 1 --ram 512   --disk 4  --vcpus 1
openstack flavor create --public z1.micro  --id 2 --ram 1024  --disk 10 --vcpus 1
openstack flavor create --public z1.small  --id 3 --ram 2048  --disk 20 --vcpus 1
openstack flavor create --public z1.medium --id 4 --ram 4096  --disk 40 --vcpus 2
openstack flavor create --public z1.large  --id 5 --ram 8192  --disk 60 --vcpus 2
openstack flavor create --public z1.xlarge --id 6 --ram 16384 --disk 80 --vcpus 4
```

Lister les saveurs :
```
openstack flavor list
```

Supprimer une saveur :
```
openstack flavor delete XXX
```
