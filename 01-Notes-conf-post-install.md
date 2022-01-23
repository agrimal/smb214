Notes de la configuration à faire après l'installation d'OpenStack
==================================================================

## Création d'un projet

```
openstack project create --domain Default smb214
openstack project list
```

## Création d'un utilisateur

Avec comme projet par défaut, celui que nous venons de créer

```
openstack user create --project smb214 --password-prompt --ignore-change-password-upon-first-use bob
openstack user list
```

## Création et import d'une clé SSH pour l'utilisateur

```
# Création
ssh-keygen -t ed25519 -f bob-id_ed25519

# Import
openstack keypair create --public-key bob-id_ed25519.pub --type ssh ma_clef
```

## Ajout du role « membre » à bob dans le projet

```
openstack role add --user bob --project smb214 member
openstack role assignment list --names --user bob
# ou
openstack role assignment list --names --user bob --project smb214
```

## Création du réseau externe et de son sous-réseau

```
openstack network create \
  --share \
  --external \
  --provider-physical-network network-external \
  --provider-network-type flat \
  net-ext

openstack network list

# sous réseau
openstack subnet create \
  --network net-ext \
  --allocation-pool start=10.123.124.2,end=10.123.124.254 \
  --dns-nameserver 9.9.9.9 \
  --gateway 10.123.124.1 \
  --subnet-range 10.123.124.0/24 \
  subnet-ext

openstack subnet list
# ou
openstack subnet list --network net-ext
```

## Création des saveurs

```
openstack flavor create --public z1.nano   --id 1 --ram 512   --disk 4  --vcpus 1
openstack flavor create --public z1.micro  --id 2 --ram 1024  --disk 10 --vcpus 1
openstack flavor create --public z1.small  --id 3 --ram 2048  --disk 20 --vcpus 1
openstack flavor create --public z1.medium --id 4 --ram 4096  --disk 40 --vcpus 2
openstack flavor create --public z1.large  --id 5 --ram 8192  --disk 60 --vcpus 2
openstack flavor create --public z1.xlarge --id 6 --ram 16384 --disk 80 --vcpus 4

openstack flavor list
```

## Import d'une image Debian

```
wget -q https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -O /tmp/debian-11.qcow2
openstack image create \
  --container-format bare \
  --disk-format qcow2 \
  --property hw_disk_bus=scsi \
  --property hw_scsi_model=virtio-scsi \
  --property os_type=linux \
  --property os_distro=debian \
  --property os_admin_user=debian \
  --property os_version='11' \
  --public \
  --file /tmp/debian-11.qcow2 \
  debian11

openstack image list
```

## Création de la stack via un template Heat (HOT)

```
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

openstack stack list
```
