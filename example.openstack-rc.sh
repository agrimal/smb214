# Exemple pour le fichier « openstack.rc »
# À completer comme il se doit, c'est mieux

export LC_ALL=en_US.UTF-8

# COMMON CINDER ENVS
export CINDER_ENDPOINT_TYPE=internalURL

# COMMON NOVA ENVS
export NOVA_ENDPOINT_TYPE=internalURL

# COMMON MANILA ENVS
export OS_MANILA_ENDPOINT_TYPE=internalURL

# COMMON OPENSTACK ENVS
export OS_ENDPOINT_TYPE=internalURL
export OS_INTERFACE=internalURL
export OS_USERNAME=USERNAME
export OS_PASSWORD='PASSWORD'
export OS_PROJECT_NAME=PROJECT
export OS_TENANT_NAME=TERNANT
export OS_AUTH_TYPE=password
export OS_AUTH_URL=https://IP_ou_FQDN:5000/v3
export OS_NO_CACHE=1
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_REGION_NAME=RegionOne

# For openstackclient
export OS_IDENTITY_API_VERSION=3
export OS_AUTH_VERSION=3

# Certificat :
# Si on est sur le serveur d'admin (de déploiement OpenStack)
#export OS_CACERT=/etc/openstack_deploy/pki/roots/ExampleCorpRoot/certs/ExampleCorpRoot.crt
# Si on est en CLI sur son PC
#export OS_CACERT=ExampleCorpRoot.crt
if [[ $HOSTNAME == "opnstk-adm" ]] ; then
    export OS_CACERT=/etc/openstack_deploy/pki/roots/ExampleCorpRoot/certs/ExampleCorpRoot.crt
else
    export OS_CACERT=ExampleCorpRoot.crt
fi
