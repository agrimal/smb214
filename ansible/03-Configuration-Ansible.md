Créer le fichier « ansible.cfg » pour définir que nous utilisont l'utilisateur « debian » pour nous connecter :

```
[defaults]
remote_user = debian
inventory = openstack_inventory.py
```


