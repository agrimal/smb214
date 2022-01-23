# Préparation

sudo mkdir /srv/venv/
sudo chown UTILISATEUR: /srv/venv/

# Installation de venv

apt install virtualenv

virtualenv -p /usr/bin/python3 /srv/venv/openstack-ansible-configure-hosts

# activation du venv

source /srv/venv/openstack-ansible-configure-hosts/bin/activate

# Installation ansible à la dernière version

pip install ansible

# Récupération des versions

pip freeze > /srv/venv/openstack-ansible-configure-hosts/requirement.txt

# Installer les modules à partir d'un « requirement »

pip install --requirement requirement.txt

