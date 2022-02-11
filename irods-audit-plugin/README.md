# iRODS Audit plugin deployment via ansible
This script eases the deployment of the Audit plugin with elisticstack and Kibana.

## Prerequisites 
To make use of this script you need the following:
*  A target Debian  machine (preferably Debian 9 Stretch)
*  Public key of the user on the host machine must be added to the authorized keys on the
target machine on a user, e.g. `myuser`, which is authorised to SUDO without password.
*  On the machine, execute: apt update; apt upgrade; apt install python python3.7.
*  On the machine, add host ip and hostname to /etc/hosts:
   `echo $(ip addr | grep -C 2 ens | grep "inet " | awk '{print $2}' | awk 'BEGIN{FS="/"} {print $1}')" "$(hostname) >>  /etc/hosts`
*  The private key of the user at the host machine must be in the default .ssh/ location, or the --private-key parameter should be passed to ansible commands.
*  Installed iRODS

## Installed applications
The script will install the following:
*  iRODS audit plugin
*  RabbitMQ
*  Elasticsearch
*  Logstash
*  Kibana

## Edit configuration parameters
To set the target host/IP run the following command:

`vi inventory/hosts.ini`

To edit some' specific parameters send the following command:

`vi inventory/group_vars/all/vars.yml`


## Installation
To deploy the architecture with the default values, run the following command:

`ansible-playbook -i ./inventory/hosts.ini playbook.yml -K -u myuser`

where myuser is the username mentioned under Prerequisites above.
**PLEASE keep a backup of /etc/irods/server_config.json since the file will be edited.**

## Maintainer
Mohamad Hayek
