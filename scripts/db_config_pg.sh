#!/bin/bash
set -e
if [ ! -f "db-pg.json" ]; then
  echo "* Create db-pg.json"
  cat <<EOF > db-pg.json
{"driver":"postgres","data_source":"postgres://postgres:cfssl@localhost/postgres?sslmode=disable"}
EOF
  echo "goos sqlite up"
  goose -path $GOPATH/src/github.com/cloudflare/cfssl/certdb/pg up
else
  echo "* DB Config already exists"
fi
