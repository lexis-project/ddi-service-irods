#!/bin/bash

echo "ssl setup"
cd /opt
mkdir certs && cd certs
sh /opt/ssl_setup.sh --self auth_microservice /opt/req.conf

echo "auth_microservice entrypoint"
uwsgi --ini /etc/uwsgi.ini  &
nginx -c /etc/nginx/nginx.conf

wait

