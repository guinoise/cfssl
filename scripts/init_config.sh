#!/bin/bash
set -e

if [ -n "${CFSSL_CA_AUTH_KEY}"]; then
  CFSSL_CA_AUTH_KEY=`openssl rand -hex 16`
  echo "Generated auth key: ${CFSSL_CA_AUTH_KEY}"
fi

if [ ! -f ${CFSSL_CA_POLICY_FILE} ]; then
  echo "* Create Config file ${CFSSL_CA_POLICY_FILE}"
  cat <<EOF > ${CFSSL_CA_POLICY_FILE}
{
  "signing": {
    "default": {
      "ocsp_url": "http://${CFSSL_CA_HOST}:8889",
      "crl_url": "http://${CFSSL_CA_HOST}:8888/crl",
      "expiry": "26280h",
      "usages": [
        "signing",
        "key encipherment",
        "client auth"
      ]
    },
    "profiles": {
      "ocsp": {
        "auth_key": "auth_key",
        "usages": [
          "digital signature",
          "ocsp signing"
        ],
        "expiry": "26280h"
      },
      "CA": {
        "auth_key": "auth_key",
        "usages": [
          "cert sign"
        ],
        "expiry": "26280h"
	  },
      "intermediate": {
        "auth_key": "auth_key",
        "usages": [
          "cert sign",
          "crl sign"
        ],
        "expiry": "26280h",
        "ca_constraint": {
          "is_ca": true
        }
      },
      "server": {
        "usages": [
          "signing",
          "key encipherment",
          "server auth"
        ],
        "expiry": "26280h"
      },
      "client": {
        "usages": [
          "signing",
          "key encipherment",
          "client auth"
        ],
        "expiry": "26280h"
      },
      "serverclient": {
        "usages": [
          "signing",
          "key encipherment",
          "client auth",
          "server auth"
        ],
        "expiry": "26280h"
      }
    }
  },
  "auth_keys": {
    "auth_key": {
      "key": "${CFSSL_CA_AUTH_KEY}",
      "type": "standard"
    }
  }
}
EOF
  echo "============"
  cat ${CFSSL_CA_POLICY_FILE}
  echo "============"  
else
  echo "* Config file ${CFSSL_CA_POLICY_FILE} exists"
fi

