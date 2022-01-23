Inventaire dynamique des instances OpenStack pour Ansible
=========================================================

Voir :
+ https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html

Deux méthodes :
+ La recommandée, activer le module d'inventaire OpenStack dans Ansible
+ Et avec le script `openstack_inventory.py`

## Activation du module d'inventaire OpenStack

Dans la conf ansible (exemple dans le `ansible.cfg`, ajouter :

```
[inventory]
enable_plugins = openstack
```

## Utilisation du script d'inventaire dynamique `openstack_inventory.py`

```
wget https://raw.githubusercontent.com/openstack/ansible-collections-openstack/master/scripts/inventory/openstack_inventory.py
chmod +x openstack_inventory.py
```

+ Récupérer le fichier « openrc » présent dans le conteneur **utility** et mettre le contenue dans le fichier `openstack.rc`
+ Récupérer le certificat SSL, par défaut `/etc/openstack_deploy/pki/roots/ExampleCorpRoot/certs/ExampleCorpRoot.crt`

```
# Sourcer le venv :
source /srv/virtualenvs/opnstk-cli/bin/activate

# Installer le module pip « openstacksdk » :
pip install openstacksdk

# Non nécessaire, mais si on souhaite avoir les outils CLI OpenStack, on peut aussi installer le module suivant :
# https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html
pip install python-openstackclient

# Tester le bon fonctionnement de l'inventaire dynamique :
./openstack_inventory.py --list
```
