# HANDLE system deployment via ansible
This script eases the deployment of the HANDLE system  on a Debian machine.

## Prerequisites 
To make use of this script you need the following:
*  A target Debian machine (preferably Debian 9)
*  Public key of the host machine must be added to the authorized keys on the
target machine on a user, e.g. `myuser`, which is authorised to SUDO without password.
*  On the machine, execute: apt update; apt upgrade; apt install python python 3
*  On the machine, add host ip and hostname to /etc/hosts:
   `echo $(ip addr | grep -C 2 ens | grep "inet " | awk '{print $2}' | awk 'BEGIN{FS="/"} {print $1}')" "$(hostname) >>  /etc/hosts`
*  python pexpect library

## Edit configuration parameters
To set the target host/IP run the following command:

`vi inventory/hosts.ini`

To edit HANDLE specific parameters send the following command:

`vi inventory/group_vars/all/vars.yml`

Default values are written inside this file.

## Installation
To deploy the HANDLE system with the default values, run the following command:

`ansible-playbook -v -i ./inventory/hosts.ini playbook.yml -K -u myuser`

where myuser is the username mentioned under Prerequisites above.


Once complete, there will be a file called 'sitebndl.zip' in your handle 
server directory which you will send to your prefixadministrator. The 
administrator will use the 'sitebndl.zip' file to create a prefix in the 
root service (GHR), and will notify you when this has been completed. 
You will not be able to continue the install until you receive information
 from the administrator concerning your prefix.

## Maintainer
Mohamad Hayek

