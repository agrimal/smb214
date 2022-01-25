Configuration des instances avec Ansible
========================================

- Installer ansible
```bash
cd ~/smb214/ansible
source /srv/virtualenvs/opnstk-cli/bin/activate
pip install ansible python-heatclient openstacksdk
```

- Configuration du fichier `clouds.yaml` (remplacer le mot de passe)
```bash
cat << EOF > clouds.yaml
---
clouds:
  smb214:
    auth:
      auth_url: https://10.123.123.11:5000/v3
      project_name: smb214
      username: bob
      password: <MOT_DE_PASSE_DE_BOB>
      user_domain_name: Default
      project_domain_name: Default
    cacert: /etc/openstack_deploy/pki/roots/ExampleCorpRoot/certs/ExampleCorpRoot.crt
    region_name: RegionOne
EOF
```

- Lancer le playbook ansible de configuration des instances
```bash
ansible-playbook playbook-configure-stack.yml
```

Voici le résultat lors d'un deuxième passage du playbook :
```
PLAY [Configuration du RVPRX] ***************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************
ok: [rvprx]

TASK [rvprx : Installation de Nginx] ********************************************************************************************
ok: [rvprx]

TASK [rvprx : Création des vhosts] **********************************************************************************************
ok: [rvprx] => (item=www-01)
ok: [rvprx] => (item=www-02)

TASK [rvprx : Activation des vhosts] ********************************************************************************************
ok: [rvprx] => (item=www-01)
ok: [rvprx] => (item=www-02)

TASK [rvprx : Rechargement de Nginx] ********************************************************************************************
skipping: [rvprx]

PLAY [Configuration des serveurs Web] *******************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************
ok: [www-01]
ok: [www-02]

TASK [www : Installation des paquets] *******************************************************************************************
ok: [www-02]
ok: [www-01]

TASK [www : include_tasks] ******************************************************************************************************
included: /srv/git/SMB214/ansible/roles/www/tasks/bootstrap.yml for www-01
included: /srv/git/SMB214/ansible/roles/www/tasks/wordpress.yml for www-02

TASK [www : Création page Web pour le site] *************************************************************************************
ok: [www-01]

TASK [www : Modification du vhost Apache2] **************************************************************************************
ok: [www-02]

TASK [www : Vérification de l'existence du fichier "/etc/ansible-do-not-install-wordpress" - Besoin de réinstaller ?] ***********
ok: [www-02]

TASK [www : Décompression de l'archive] *****************************************************************************************
skipping: [www-02]

TASK [www : Création du fichier "/etc/ansible-do-not-install-wordpress" - Blocage de l'installation] ****************************
ok: [www-02]

TASK [www : Copie du fichier de configuration de Wordpress] *********************************************************************
skipping: [www-02]

TASK [www : Apache2 - Activation des modules] ***********************************************************************************
ok: [www-02] => (item=proxy_fcgi)
ok: [www-02] => (item=setenvif)

TASK [www : Apache2 - Activation des confs] *************************************************************************************
ok: [www-02] => (item=php7.4-fpm)

PLAY [Configuration de la BDD] **************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************
ok: [db]

TASK [db : Installation de MariaDB] *********************************************************************************************
ok: [db]

TASK [db : Configuration MariaDB - Écouter sur l'interface de Backend DB] *******************************************************
ok: [db]

TASK [db : Création des bases MariaDB] ******************************************************************************************
skipping: [db] => (item=www-01) 
ok: [db] => (item=www-02)

TASK [db : Création des utilisateurs MariaDB] ***********************************************************************************
skipping: [db] => (item=www-01) 
ok: [db] => (item=www-02)

TASK [db : Redémarrage de MariaDB] **********************************************************************************************
skipping: [db]

PLAY RECAP **********************************************************************************************************************
db                         : ok=5    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
rvprx                      : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
www-01                     : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
www-02                     : ok=8    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
```
