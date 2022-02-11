FROM centos:latest

# Current version of OpenID plugin is built against this iRODS version
ARG iv=4.2.3-1
ARG plugin=2.2.0-1
ARG token

RUN yum install -y epel-release postgresql-server postgresql-odbc vim wget htop git rpm-build
RUN rpm --import https://packages.irods.org/irods-signing-key.asc &&\
wget -qO - https://packages.irods.org/renci-irods.yum.repo | tee /etc/yum.repos.d/renci-irods.yum.repo
RUN yum update -y
RUN yum install -y irods-server-$iv irods-database-plugin-postgres-$iv

RUN echo python /var/lib/irods/scripts/setup_irods.py > /usr/local/bin/setup_irods&&\
 chmod +x /usr/local/bin/setup_irods

# Install OpenID plugin
RUN curl -o irods-auth-plugin-openid-$plugin.x86_64.rpm --location --header "PRIVATE-TOKEN: $token" "https://code.it4i.cz/api/v4/projects/664/jobs/artifacts/master/raw/irods_auth_plugin_openid/irods-auth-plugin-openid-$plugin.x86_64.rpm?job=build-openid-plugin" && rpm -ivh irods-auth-plugin-openid-$plugin.x86_64.rpm


COPY docker-entrypoint.sh /usr/local/bin/
COPY provider.txt /opt
COPY consumer.txt /opt

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
