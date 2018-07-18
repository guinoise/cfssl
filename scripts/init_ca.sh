#!/bin/bash
set -e

if [ ! -f "ca.pem" ];then
  echo "* Create CA request ca.json"
  cat <<EOF > ca.json
{
  "CN": "Certificate Authority L1 : ${CFSSL_CA_ORGANIZATION}",
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
  }]
}
EOF
  echo "============"
  cat ca.json
  echo "============"
  echo "Geneate ROOT CA"
  cfssl genkey -initca ca.json | cfssljson -bare ca 
else
  echo "* ROOT CA already exists"
fi
