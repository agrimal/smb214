Inventaire dynamique des instances OpenStack pour Ansible
=========================================================

Documentation : [dynamic_inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html)

Deux méthodes :
- Recommandée : activer le module d'inventaire OpenStack dans Ansible
- Autre : avec le script `openstack_inventory.py`

Une fois configuré, tester le bon fonctionnement de l'inventaire dynamique :
```bash
./openstack_inventory.py --list
```

## Activation du module d'inventaire OpenStack

Dans la configuration ansible (exemple dans le fichier `ansible.cfg`), ajouter :

```bash
[inventory]
enable_plugins = openstack.cloud.openstack,auto,host_list,yaml,ini,toml,script
```

## Utilisation du script d'inventaire dynamique `openstack_inventory.py`

```bash
wget https://raw.githubusercontent.com/openstack/ansible-collections-openstack/master/scripts/inventory/openstack_inventory.py
chmod +x openstack_inventory.py
```
