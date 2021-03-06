#!/bin/bash

# Usage:
#
# ssl_setup [--self] <name> <csr_config>
#
# This script is used to generate key and CSR for use HTTPS in Nginx.
#
# --self        Generate self-signed certificate in addition to key and CSR.
# name          Output files will be named as <name>.key and <name>.csr.
# csr_config    Path to file that specifies CSR information. See below.
#
# CSR configuration format:
#
# [ req ]
# distinguished_name="req_distinguished_name"
# prompt="no"
#
# [ req_distinguished_name ]
# C="US"
# ST="California"
# L="Albany"
# O="55 Minutes Inc."
# CN="www.55minutes.com"

if [[ $1 == --self ]]; then
  SELF_SIGN=1
  shift
fi

KEY_NAME=$1
CSR_CONFIG=$2

openssl req -config $CSR_CONFIG -new -newkey rsa:2048 -nodes -keyout ${KEY_NAME}.key -out ${KEY_NAME}.csr

echo "Created ${KEY_NAME}.key"
echo "Created ${KEY_NAME}.csr"

if [[ -n $SELF_SIGN ]]; then
  openssl x509 -req -days 365 -in ${KEY_NAME}.csr -signkey ${KEY_NAME}.key -out ${KEY_NAME}.crt
  echo "Created ${KEY_NAME}.crt (self-signed)"
fi
