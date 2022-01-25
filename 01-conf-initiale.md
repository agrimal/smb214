Configuration initiale des serveurs Openstack
=============================================

## Caractéristiques

Serveur de déploiement :
- Nom : `opnstk-adm`
- CPU : 4
- Mémoire : 8 Go
- OS : Debian 10 Buster

Serveur d'hébergement :
- Nom : `opnstk-node01`
- CPU : 12
- Mémoire : 64 Go
- OS : Debian 10 Buster
- Volumétrie
  - `/` : 10 Go
  - `/var`: 50 Go
  - un disque libre de 100 Go pour Cinder

Configuration réseau :
- opnstk-adm : voir fichier [/etc/network/interfaces](./config/opnstk-adm/etc/network/interfaces)
- opnstk-node01 : voir fichier [/etc/network/interfaces](./config/opnstk-node01/etc/network/interfaces)
- voir [schéma réseau](./images/schema-reseau-serveurs.svg)

## Configuration du serveur de déploiement

- Installation des paquets
```bash
apt install build-essential git chrony openssh-server python3-dev sudo python3-openssl python3-cryptography python3-pip
```

- Configuration du fichier `/etc/hosts`
```bash
echo "10.123.123.11 opnstk-node01" | tee -a /etc/hosts
```

- Autoriser la connexion SSH depuis `root@opnstk-adm` vers `root@opnstk-node01`
  - sur opnstk-adm, récupérer la clef publique : `cat .ssh/id_rsa.pub` (cette clef est créée lors du bootstrap)
  - sur opnstk-node01, ajouter la clef publique dans le fichier `/root/.ssh/authorized_keys`
  - vérifier la connexion depuis opnstk-adm : `ssh root@opnstk-node01`

- Documentation de référence : [Prepare the deployment host](https://docs.openstack.org/project-deploy-guide/openstack-ansible/xena/deploymenthost.html)

## Configuration du serveur d'hébergement

- Installation des paquets
```bash
apt install bridge-utils debootstrap ifenslave ifenslave-2.6 lsof lvm2 openssh-server sudo tcpdump vlan python3
```

- Création du volumegroup LVM pour cinder
```bash
# remplacer /dev/sdX par le chemin du disque de 100 GO dédié à cinder
pvcreate --metadatasize 2048 /dev/sdX
vgcreate cinder-volumes /dev/sdX
```

- Documentation de référence : [Prepare the target hosts](https://docs.openstack.org/project-deploy-guide/openstack-ansible/xena/targethosts.html)
