#!/bin/bash
set -e

if [ ! -f "server.pem" ];then
  echo "* Create Intermediate CA request server.json"
  cat <<EOF > server.json
{
  "hosts": [
    $(echo "\"${CFSSL_CA_HOST//,/\",\"}\""),"localhost","127.0.0.1"
  ],
  "key": {
    "algo": "${CFSSL_CA_ALGO}",
    "size": ${CFSSL_CA_KEY_SIZE}
  },
  "names": [{
    "C": "${CFSSL_CA_COUNTRY}",
    "ST": "${CFSSL_CA_STATE}",
    "L": "${CFSSL_CA_CITY}",
    "O": "${CFSSL_CA_ORGANIZATION}",
    "OU": "${CFSSL_CA_ORGANIZATIONAL_UNIT}"
  }],
  "CN": "Certificate Authority L2 : ${CFSSL_CA_ORGANIZATION}"
}
EOF
  echo "============"
  cat server.json
  echo "============"
  echo "* Generate certificate"
  cfssl gencert -ca ca.pem -ca-key ca-key.pem -config=${CFSSL_CA_POLICY_FILE} -profile="intermediate" server.json | cfssljson -bare server 
  cat server.pem ca.pem > server-bundle.pem
else
  echo "* Intermediate CA already exists"
fi

