# ddi-service-irods
iRODS zone deployment for LEXIS centres: this repository contains components for the 1st (lowest) level of the DDI.

## Acknowledgement
This code repository is a result / contains results of the LEXIS project. The project has received funding from the European Union’s Horizon 2020 Research and Innovation programme (2014-2020) under grant agreement No. 825532.

## Structure
- ansible: Roles to deploy iRODS and its plugins
- docker: Dockerfiles for development environment to build plugins
- eudat: Ansible roles to install B2HANDLE, B2SHARE to iRODS
- irods-audit-plugin: Ansible role to deploy auditing plugin for iRODS and ELK stack
- irods-openid-auth: Auth_microservice and OpenID plugin for iRODS
