Configuration Ansible
=====================

Créer le fichier « ansible.cfg » pour définir que nous utilisont l'utilisateur « debian » pour nous connecter :

```
[defaults]
remote_user = debian
inventory = openstack_inventory.py
```

Et pour activer le module d'inventaire dynamique OpenStack (comme vu dans la fichier précédent) :

```
[inventory]
enable_plugins = openstack
```
