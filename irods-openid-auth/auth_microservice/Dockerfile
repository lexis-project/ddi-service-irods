FROM centos:7

ARG token

WORKDIR /opt

RUN yum install -y epel-release gcc 
RUN yum install -y python36 python36-pip python36-devel uwsgi uwsgi-plugin-python36 nginx postgresql git
RUN pip3 install --upgrade pip
RUN pip3 install psycopg2-binary

# Upstream
# RUN git clone https://github.com/heliumdatacommons/auth_microservice.git

# Fork
RUN git clone https://mgolas:$token@code.it4i.cz/lexis/wp3/irods-openid-auth.git

RUN cd irods-openid-auth/auth_microservice/auth_microservice && pip3 install .

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY uwsgi.ini /etc/uwsgi.ini
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY req.conf /opt/
COPY ssl_setup.sh /opt/

EXPOSE 8080/tcp

ENTRYPOINT /bin/bash /usr/bin/entrypoint.sh

