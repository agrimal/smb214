Installation d'Openstack
========================

Toutes les commandes doivent être exécutée sur le serveur `opnstk-adm`

- Téléchargement du dépôt git `openstack-ansible`
```bash
git clone -b 24.0.0 https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible
```

- Lancement du bootstrap openstack-ansible
```bash
cd /opt/openstack-ansible
./scripts/bootstrap-ansible.sh
```

- Installation du SDK OpenStack
```bash
pip3 install --upgrade pip
pip3 install openstacksdk
```

- Mise en place de la configuration
```bash
cp -ra /opt/openstack-ansible/etc/openstack_deploy /etc/openstack_deploy
cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml
```

- Adapter les fichiers à la configuration voulue :
  - [/etc/openstack_deploy/openstack_user_config.yml](./config/opnstk-adm/etc/openstack_deploy/openstack_user_config.yml)
  - [/etc/openstack_deploy/user_variables.yml](./config/opnstk-adm/etc/openstack_deploy/user_variables.yml)

- Générations des secrets
```bash
./scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml
```

- Lancer le playbook setup-hosts
```bash
cd /opt/openstack-ansible/playbooks
openstack-ansible setup-hosts.yml
```

- Installer les modules python supplémentaires dans les conteneurs LXC
```bash
ansible -i ../inventory/dynamic_inventory.py -m apt -a "name=python3-mysqldb,python3-openstacksdk" all_containers
```

- Lancer le playbook setup-infrastructure
```bash
cd /opt/openstack-ansible/playbooks
openstack-ansible setup-infrastructure.yml
```

- Lancer le playbook setup-openstack
```bash
cd /opt/openstack-ansible/playbooks
openstack-ansible setup-openstack.yml
```

- Documentation de référence :
  - [Configure the deployment](https://docs.openstack.org/project-deploy-guide/openstack-ansible/xena/configure.html)
  - [Run playbooks](https://docs.openstack.org/project-deploy-guide/openstack-ansible/xena/run-playbooks.html)
