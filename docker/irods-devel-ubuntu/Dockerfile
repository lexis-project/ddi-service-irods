FROM ubuntu:16.04

# iRODS version to install
ARG iv=4.2.3-1

RUN apt-get update && apt-get -y install vim htop git curl apt-transport-https ca-certificates apt-utils build-essential
RUN curl https://packages.irods.org/irods-signing-key.asc | apt-key add -
RUN echo "deb [arch=amd64] https://packages.irods.org/apt/ xenial main" | tee /etc/apt/sources.list.d/renci-irods.list
RUN apt-get -y update && apt-get -y upgrade

RUN apt install -y irods-server=$iv irods-database-plugin-postgres=$iv irods-dev=$iv irods-runtime=$iv irods-icommands=$iv

# Warning - this one takes >1GB !!
RUN apt install -y irods-externals-*

ENTRYPOINT ["/bin/bash"]
