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
