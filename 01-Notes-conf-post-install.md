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


