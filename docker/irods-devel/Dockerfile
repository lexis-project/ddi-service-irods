FROM centos:7

# iRODS version to install
ARG iv=4.2.3-1

RUN yum install -y epel-release postgresql-server postgresql-odbc vim wget htop git rpm-build
RUN rpm --import https://packages.irods.org/irods-signing-key.asc &&\
wget -qO - https://packages.irods.org/renci-irods.yum.repo | tee /etc/yum.repos.d/renci-irods.yum.repo
RUN yum update -y
RUN yum install -y irods-server-$iv irods-database-plugin-postgres-$iv irods-devel-$iv irods-externals-* python36 python36-pip python36-devel && pip3 install --upgrade pip psycopg2-binary
RUN yum groupinstall -y "Development Tools"
RUN yum install -y cmake3 libcurl-devel openssl-devel 
RUN yum clean all


ENTRYPOINT ["/bin/bash"]
