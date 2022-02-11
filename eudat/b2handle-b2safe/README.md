# EUDAT B2HANDLE and B2SAFE deployment via ansible
This script eases the deployment of B2HANDLE and B2SAFE on an Ubuntu machine.

## Prerequisites 
To make use of this script you need the following:
*  A target ubuntu machine (preferably 16.04)
*  Public key of the host machine must be added to the authorized keys on the
target machine on a user, e.g. `myuser`, which is authorised to SUDO without password.
*  On the machine, execute: apt update; apt upgrade; apt install python python 3
*  On the machine, add host ip and hostname to /etc/hosts:
   `echo $(ip addr | grep -C 2 ens | grep "inet " | awk '{print $2}' | awk 'BEGIN{FS="/"} {print $1}')" "$(hostname) >>  /etc/hosts`
*  iRODS version 4.2.5 or 4.2.6

## Edit configuration parameters
To set the target host/IP run the following command:

`vi inventory/hosts.ini`

To edit B2SAFE specific parameters send the following command:

`vi inventory/group_vars/all/vars.yml`

Some sensitive parameters are saved in an ansible vault. To access and edit
these values, send the following command:

`ansible-vault edit inventory/group_vars/all/vault.yml`

You will be prompted to enter a password. The default password is "testpassword"
and it's possible (and recommended) to update it.

## Installation
To deploy B2HANDLE and B2SAFE with the default values, run the following command:

`ansible-playbook -v -i ./inventory/hosts.ini --ask-vault-pass playbook.yml -K -u myuser`

where myuser is the username mentioned under Prerequisites above.

##Maintainer
Mohamad Hayek

