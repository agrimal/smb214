# Préparation

sudo mkdir /srv/virtualenvs/
sudo chown UTILISATEUR: /srv/virtualenvs/

# Installation de venv

apt install virtualenv

virtualenv -p /usr/bin/python3 /srv/virtualenvs/opnstk-cli

# activation du venv

source /srv/virtualenvs/opnstk-cli/bin/activate

# Installation ansible à la dernière version

pip install ansible

# Récupération des versions

pip freeze > /srv/virtualenvs/opnstk-cli/requirement.txt

# Installer les modules à partir d'un « requirement »

pip install --requirement requirement.txt

