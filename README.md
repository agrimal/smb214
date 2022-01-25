# Documentation technique du projet SMB214
#### 2021-2022 Semestre 1

Cette documentation technique a pour objectif de présenter :
- l'installation et la configuration d'un environnement de test OpenStack via [openstack-ansible](https://docs.openstack.org/openstack-ansible/latest)
- la création en mode `infrastructure-as-code` d'une infrastructure dans Openstack (bastion, reverse-proxy, serveurs webs et base de données)
- la configuration de cette infrastructure via ansible

Liste des étapes :
1. Configuration initiale des serveurs Openstack : [01-conf-initiale.md](./01-conf-initiale.md)
2. Installation d'Openstack : [02-installation-openstack.md](./02-installation-openstack.md)
3. Configuration de l'environnement OpenStack après installation : [03-doc-conf-openstack-post-install.md](./03-doc-conf-openstack-post-install.md)
4. Création des ressources dans Openstack avec Heat : [04-creation-stack-heat.md](./04-creation-stack-heat.md)
5. Configuration des instances avec ansible : [05-configuration-instances-ansible.md](./05-configuration-instances-ansible.md)
