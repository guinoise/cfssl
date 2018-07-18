#!/bin/bash
set -e
if [ ! -f "db-config.json" ]; then
  echo "* Create db-config.json"
  cat <<EOF > db-config.json
{"driver":"sqlite3","data_source":"certstore_development.db"}
EOF
  echo "goos sqlite up"
  goose -path $GOPATH/src/github.com/cloudflare/cfssl/certdb/sqlite up
else
  echo "* DB Config already exists"
fi
