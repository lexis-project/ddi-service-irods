# EUDAT GLOBUS-B2STAGE deployment via ansible
This script eases the deployment of EUDAT B2STAGE

## Prerequisites 
To make use of this script you need the following:
*  A target Debian machine (preferably stretch)
*  Public key of the user on the host machine must be added to the authorized keys on the
target machine on a user, e.g. `myuser`, which is authorised to SUDO without password.
*  On the machine, execute: apt update; apt upgrade; apt install python python3
*  On the machine, add host ip and hostname to /etc/hosts:
   `echo $(ip addr | grep -C 2 ens | grep "inet " | awk '{print $2}' | awk 'BEGIN{FS="/"} {print $1}')" "$(hostname) >>  /etc/hosts`
*  The private key of the user at the host machine must be in the default .ssh/ location, or the --private-key parameter should be passed to ansible commands.
*  iRODS externals package installed

## Edit configuration parameters
To set the target host/IP run the following command:

`vi inventory/hosts.ini`

To edit B2STAGE' specific parameters send the following command:

`vi inventory/group_vars/all/vars.yml`


## Installation
To deploy B2STAGE with the default values, run the following command:

`ansible-playbook -i ./inventory/hosts.ini playbook.yml -K -u myuser`

where myuser is the username mentioned under Prerequisites above.


In case you don't have a Handle prefix yet, comment the last play.


Multiple issues appears when running "make install" of the packages. Erros are
different depending on the linux distribution. Use the -vvv option when running
ansible to get more logging and see if any specific error occurs.

## Maintainer
Mohamad Hayek
