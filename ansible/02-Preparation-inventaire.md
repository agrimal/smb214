Voir :

https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html

wget https://raw.githubusercontent.com/openstack/ansible-collections-openstack/master/scripts/inventory/openstack_inventory.py
chmod +x openstack_inventory.py

Récupérer le fichier « openrc » présent dans le conteneur « utility » et mettre le contenue dans le fichier « openstack.rc »
Récupérer le certificat SSL, par défaut « /etc/openstack_deploy/pki/roots/ExampleCorpRoot/certs/ExampleCorpRoot.crt »

Sourcer le venv :
source /srv/venv/openstack-ansible-configure-hosts/bin/activate

Installer le module pip « openstacksdk » :
pip install openstacksdk

https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html
Non nécessaire, mais si on souhaite avoir les outils CLI OpenStack, on peut aussi installer le module suivant :
pip install python-openstackclient

Tester le bon fonctionnement :
./openstack_inventory.py --list

Si ça ne marche pas, penser à vérifier « OS_PROJECT_NAME » dans « openstack.rc »
