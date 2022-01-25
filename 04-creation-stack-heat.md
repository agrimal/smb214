Création de l'infrastructure avec Heat
======================================

Les commandes doivent être exécutées sur `opnstk-adm`

- Création de la stack Heat
```bash
cd ~/smb214
source bob.openstack-rc.sh
openstack stack create \
  -t Heat-Orchestration-Template.yml \
  --parameter key-name=clef_ssh_de_bob \
  --parameter image=debian11 \
  --parameter flavor-bastion=z1.micro \
  --parameter flavor-rvprx=z1.small \
  --parameter flavor-db=z1.small \
  --parameter flavor-www=z1.medium \
  --parameter public-net=net-ext \
  SMB214
```

- Vérification de la stack Heat
```bash
openstack stack list
```
