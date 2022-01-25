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
  --parameter flavor-bastion=z1.nano \
  --parameter flavor-rvprx=z1.micro \
  --parameter flavor-db=z1.micro \
  --parameter flavor-www=z1.nano \
  --parameter public-net=net-ext \
  SMB214
```

- Vérification de la stack Heat
```bash
openstack stack list
```

- En cas de besoin, mise à jour de la stack
```bash
openstack stack update \
    -t Heat-Orchestration-Template.yml \
    --parameter key-name=ma_clef \
    --parameter image=debian11 \
    --parameter flavor-bastion=z1.micro \
    --parameter flavor-rvprx=z1.small \
    --parameter flavor-db=z1.small \
    --parameter flavor-www=z1.medium \
    --parameter public-net=net-ext \
    SMB214
```

- Documentation sur la rédaction d'un template Heat : [Heat template guide](https://docs.openstack.org/heat/latest/template_guide/openstack.html)
