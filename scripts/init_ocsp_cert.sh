#!/bin/bash
set -e

if [ ! -f "ocsp.csr.json" ]; then
  echo "* Create OCSP CSR ocsp.csr.json"
  cat <<EOF > ocsp.csr.json
{
  "hosts": [
    $(echo "\"${CFSSL_CA_HOST//,/\",\"}\""),"localhost","127.0.0.1"
  ],
  "CN": "OCSP signer",
  "names": [{
    "C": "${CFSSL_CA_COUNTRY}",
    "ST": "${CFSSL_CA_STATE}",
    "L": "${CFSSL_CA_CITY}",
    "O": "${CFSSL_CA_ORGANIZATION}",
    "OU": "${CFSSL_CA_ORGANIZATIONAL_UNIT}"
  }],
  "key": {
    "algo": "${CFSSL_CA_ALGO}",
    "size": ${CFSSL_CA_KEY_SIZE}
  }
}
EOF
  echo "============"
  cat ocsp.csr.json
  echo "============"
  echo "* Generate ocsp certs in ocsp sub directory"
  mkdir -p ocsp
  cfssl gencert -ca server.pem -ca-key server-key.pem -config ${CFSSL_CA_POLICY_FILE} -profile="ocsp" ocsp.csr.json| cfssljson -bare ocsp/ocsp 
else
  echo "* OCSP already exists"
fi

