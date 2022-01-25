Configuration d'Openstack après installation
==============================================

## Installation du CLI OpenStack sur opnstk-adm

Les commandes doivent être exécutées sur `opnstk-adm`

- Clône de ce dépôt
```bash
cd
git clone https://github.com/agrimal/smb214.git
```

- Création du virtualenv
```bash
mkdir /srv/virtualenvs
virtualenv -p python3 /srv/virtualenvs/opnstk-cli
source /srv/virtualenvs/opnstk-cli/bin/activate
pip install python-openstackclient
```

- Identifier le nom du conteneur utility
```bash
utility_container=$(awk '/utility_container/ {print $4}' /etc/hosts)
echo "Le conteneur utility est $utility_container"
```

- Récupération du fichier openrc du compte admin
```bash
cd ~/smb214
scp utility_container:/root/openrc admin.openstack-rc.sh
source admin.openstack-rc.sh
```

Le mot de passe du compte `admin` peut se récupérer de plusieurs façons :
- `awk '/^keystone_auth_admin_password/ {print $2}' /etc/openstack_deploy/user_secrets.yml`
- `echo $OS_PASSWORD` après avoir sourcé le fichier `admin.openstack-rc.sh`

## Actions administrateur (compte admin)

Ces actions sont à effectuer avec le compte admin.  

#### Création d'un projet

Créer le projet `smb214`

```bash
openstack project create --domain default smb214
openstack project list
```

#### Création d'un utilisateur

Créer l'utilisateur `bob` rattaché au projet `smb214`

```bash
openstack user create --project smb214 --password-prompt --ignore-change-password-upon-first-use bob
openstack user list
```

#### Ajout de privilèges à un utilisateur

Ajout du rôle `member` à l'utilisateur `bob` pour le projet `smb214`

```bash
openstack role add --user bob --project smb214 member
openstack role assignment list --names --user bob
```

#### Création du réseau externe et de son sous-réseau

Il faut créer le réseau externe afin que les instances puissent communiquer avec l'extérieur.
On y rajoute un serveur DHCP sur la plage `10.123.124.2-10.123.124.254`.

```bash
# création du réseau
openstack network create --share --external \
  --provider-physical-network network-external \
  --provider-network-type flat \
  net-ext

# liste des réseaux
openstack network list

# sous-réseau
openstack subnet create --network net-ext \
  --allocation-pool start=10.123.124.2,end=10.123.124.254 \
  --dns-nameserver 8.8.8.8 \
  --gateway 10.123.124.1 \
  --subnet-range 10.123.124.0/24 \
  subnet-ext

# liste des sous-réseaux
openstack subnet list
openstack subnet list --network net-ext
```

#### Création des gabarits

Les gabarits (flavors) permettent de fixer les ressources allouées aux instances lors de leur création.

```
# création des gabarits
openstack flavor create --public z1.nano   --id 1 --ram 512   --disk 4  --vcpus 1
openstack flavor create --public z1.micro  --id 2 --ram 1024  --disk 10 --vcpus 1
openstack flavor create --public z1.small  --id 3 --ram 2048  --disk 20 --vcpus 1
openstack flavor create --public z1.medium --id 4 --ram 4096  --disk 40 --vcpus 2
openstack flavor create --public z1.large  --id 5 --ram 8192  --disk 60 --vcpus 2
openstack flavor create --public z1.xlarge --id 6 --ram 16384 --disk 80 --vcpus 4

# liste des gabarits
openstack flavor list
```

#### Import d'une image

Mise à disposition d'une image d'un système d'exploitation (ici Debian 11 Bullseye) afin de pouvoir créer les instances.

```
# téléchargement de l'image
wget -q https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2 -O /tmp/debian-11.qcow2

# ajout de l'image dans Openstack
openstack image create --public \
  --container-format bare \
  --disk-format qcow2 \
  --property hw_disk_bus=scsi \
  --property hw_scsi_model=virtio-scsi \
  --property os_type=linux \
  --property os_distro=debian \
  --property os_admin_user=debian \
  --property os_version='11' \
  --file /tmp/debian-11.qcow2 \
  debian11

# liste des images
openstack image list
```

## Actions utilisateur (compte bob)

Ces actions sont à effectuer avec le compte bob, créé précédemment.  

#### Récupération du fichier openrc

Étapes :
- se connecter à l'interface web d'Openstack avec le compte bob.  
- en haut à droite, cliquer sur `bob` puis sur `Fichier OpenStack RC`.  
- l'enregistrer dans le répertoire `~/smb214` sous le nom `bob.openstack-rc.sh`.  

Il est également possible de créer le fichier openrc en adaptant cet exemple avec les bonnes valeurs :
```bash
#!/usr/bin/env bash
export OS_AUTH_URL=https://10.123.123.11:5000
export OS_PROJECT_ID=<A_REMPLACER>
export OS_PROJECT_NAME="smb214"
export OS_USER_DOMAIN_NAME="Default"
if [ -z "$OS_USER_DOMAIN_NAME" ]; then unset OS_USER_DOMAIN_NAME; fi
export OS_PROJECT_DOMAIN_ID="default"
unset OS_TENANT_ID
unset OS_TENANT_NAME
export OS_USERNAME="bob"
echo "Please enter your OpenStack Password for project $OS_PROJECT_NAME as user $OS_USERNAME: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=$OS_PASSWORD_INPUT
export OS_REGION_NAME="RegionOne"
export OS_INTERFACE=public
export OS_IDENTITY_API_VERSION=3
if [ "$HOSTNAME" = "opnstk-adm" ]; then
    export OS_CACERT="/etc/openstack_deploy/pki/roots/ExampleCorpRoot/certs/ExampleCorpRoot.crt"
else
    # Il faut récupération le certificat de l'autorité de certification si on se trouve sur une autre machine
    export OS_CACERT="ExampleCorpRoot.crt"
fi
```

#### Application des variables d'environnement de l'utilisateur bob

Il est important d'utiliser le fichier openrc de bob et non celui du compte admin.

```bash
cd ~/smb214
source bob.openstack-rc.sh
```

#### Création et import d'une clé SSH pour l'utilisateur

L'utilisateur bob doit pouvoir se connecter en SSH à ses instances.  
On enregistre sa clef sous le nom de `clef_ssh_de_bob`.

```bash
# création d'une paire de clefs SSH pour bob
ssh-keygen -t ed25519 -f bob-id_ed25519

# import dans openstack de la clef publique de bob
openstack keypair create --public-key bob-id_ed25519.pub --type ssh clef_ssh_de_bob
```

#### Création des règles de sécurité

A faire uniquement si on ne veut pas les créer dans le template Heat.
Le template Heat fourni par la suite crée ces règles de sécurité.
Elles sont présentées ici pour l'exemple.

```bash
# règles pour le bastion
openstack security group create bastion
openstack security group rule create --proto tcp  --remote-ip 0.0.0.0/0 --dst-port 22 bastion
openstack security group rule create --proto icmp --remote-ip 0.0.0.0/0               bastion

# règles pour le reverse-proxy
openstack security group create rvprx
openstack security group rule create --proto tcp  --remote-ip 0.0.0.0/0 --dst-port 80  rvprx
openstack security group rule create --proto tcp  --remote-ip 0.0.0.0/0 --dst-port 443 rvprx
openstack security group rule create --proto icmp --remote-ip 0.0.0.0/0                rvprx

# règles pour les serveurs de backend (pour ssh)
openstack security group create backend
openstack security group rule create --proto tcp  --remote-group bastion --dst-port 22 backend
openstack security group rule create --proto icmp --remote-group bastion backend

# règles pour permettre au reverse-proxy d'accéder aux serveurs web en http
openstack security group create www
openstack security group rule create --proto tcp --remote-group rvprx --dst-port 80 www
openstack security group rule create --proto icmp --remote-group rvprx www

# règles pour permettre aux serveurs web d'accéder à la base de données en mysql
openstack security group create db
openstack security group rule create --proto tcp --remote-group www --dst-port 3306 db
```
