# IRODS deployment via ansible
This script eases the deployment of the latest version iRODS on an Ubuntu machine.

## Prerequisites 
To make use of this script you need the following:
*  4 target ubuntu machines (preferably 16.04; in particular these scripts require postgresql 9.5)
  *  For irods 4.2.10, preferably 18.4.x.
  *  For ubuntu 18.4 (postgresql 10), a recent version of ansible. Version 2.5.1 will not work. Version 2.9.24 works.
*  Public key of the user at the host machine must be added to the authorized keys on the
target machine on a user, e.g. `myuser`, which is authorised to SUDO without password.
*  On the target machines, execute: apt update; apt upgrade; apt install python python3
*  If you have debian 10, run 
```
apt-get update -y --allow-releaseinfo-change
```
*  On the target machines, add its ip and hostname to /etc/hosts.
Example code for the LRZ cloud ubuntu instances:
   `echo $(ip addr | grep -C 2 ens | grep "inet " | awk '{print $2}' | awk 'BEGIN{FS="/"} {print $1}')" "$(hostname) >>  /etc/hosts`
*  The private key of the user at the host machine must be in the default .ssh/ location, or the --private-key parameter should be passed to ansible commands.


## Edit configuration parameters
To set the target host/IP run the following command:

`vi inventory/hosts.ini`

To edit iRODS' specific parameters send the following command:

`vi inventory/group_vars/all/vars.yml`

Some sensitive parameters are saved in an ansible vault. To access and edit
these values, send the following command:

`ansible-vault edit inventory/group_vars/all/vault.yml`

You will be prompted to enter a password. The default password is "testpassword"
and it's possible (and recommended) to update it.

Copy the private and public keys of the certificate for the python broker (auth_microservice.pem, auth_microservice.key) to
roles/python-broker/files/
Copy the public and private keys and chain for irods to (cert.key, cert.pem, chain.pem)
roles/irods-openid-config/files/

### distribution version and iRODS version

- Go to roles/irods and create a symbolic link from tasks-\<desired version> to tasks.
- Go to roles/irods-openid and create a symbolic link from tasks-\<desired version> to tasks.
- Go to roles/irods-repo and create a symbolic link from tasks-\<desired version> to tasks.
- Go to roles/postgresql and create a symbolic link from tasks-\<desired version> to tasks.
- Go to roles/dbconfig and create a symbolic link from tasks-\<desired version> to tasks.

## Installation
To deploy iRODS with the default values, run the following command:

`ansible-playbook -i ./inventory/hosts.ini --ask-vault-pass playbook.yml -K -u myuser`

where myuser is the username mentioned under Prerequisites above.
The admin user for irods (rods) password is in the vault under vault_irods_admin_password.

iRODS OpenID uses an additional set of TCP ports for token exchange. See irods-openid-config/tasks/install.yml.
By default, 20200-20399. Open these in the firewall in addition to other iRODS ports.

## Additional considerations

Since the keycloak tokens are too large to traverse the irods-client <-> irods-server interface, you will need to use the modified python irods library at
https://github.com/RubenGarcia/python-irodsclient/tree/openid

This library hashes the token if it is larger than 1024 bytes. 
If you are using a different library (e.g. go) or the command line, you will need to modify it to enable the use of hashes.

You will need to validate your token first against the python broker (https://github.com/RubenGarcia/auth_microservice)
before you can use a hash to authentificate.

If your credentials are not accepted, the python broker will send an authentification URL, which you can use to have the user authentificate.
Your request will block until after the user authentificates; then it will proceed and you will receive your data.

If you patch another irods library or icommands, or if you need assistance, contact garcia@lrz.de.

### Use the ansible scripts within the api repository to install the required lexis wp3 apis

See roles/irods-api/README.md for details.

### Use of these ansible scripts within the LRZ cloud

The following rules should be added as security groups to the relevant machines:
- Ingress, port TCP 5432, on database machine, from irods, broker and webserver.
- Ingress, port TCP 443, on broker machine and webserver machine.
- Ingress, port TCP 20200-20399, on irods machine (irods - broker communication)
- Ingress, port TCP 20000-20199 (port_min and port_max in inventory/group_vars/all/vars.yml), on irods machine (irods transfer)
- Ingress, port TCP 1247, 1248 on irods machine (irods protocol)

##Maintainers

Mohamad Hayek <Mohamad.Hayek@lrz.de>
Rubén Jesús García Hernández <garcia@lrz.de>
