#!/bin/bash
set -eo pipefail

#cfssl serve -address=${CFSSL_ADDRESS} -port=8888 -config=${CFSSL_CA_POLICY_FILE} -ca-bundle=/etc/cfssl/ca-bundle.crt -int-bundle=/etc/cfssl/data/server-bundle.pem -int-dir=/etc/cfssl/data/intermediates -db-config=/etc/cfssl/data/db-config.json -responder=/etc/cfssl/data/ocsp/ocsp.pem -responder-key=/etc/cfssl/data/ocsp/ocsp-key.pem -ca=/etc/cfssl/data/server.pem -ca-key=/etc/cfssl/data/server-key.pem 
cfssl serve -address=${CFSSL_ADDRESS} -port=8888 -config=${CFSSL_CA_POLICY_FILE} -ca-bundle=/etc/cfssl/data/server-bundle.pem -int-dir=/etc/cfssl/data/intermediates -db-config=/etc/cfssl/data/db-config.json -responder=/etc/cfssl/data/ocsp/ocsp.pem -responder-key=/etc/cfssl/data/ocsp/ocsp-key.pem -ca=/etc/cfssl/data/server.pem -ca-key=/etc/cfssl/data/server-key.pem -loglevel=0

#exec nginx -c /etc/nginx/nginx.conf

# vim: set ft=sh:
