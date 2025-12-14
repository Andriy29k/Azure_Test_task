#!/bin/bash
set -euo pipefail

ENV_FILE="/home/${USER}/.database_env"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "ERROR: ${ENV_FILE} not found"
  exit 1
fi

set -a
source "${ENV_FILE}"
set +a

env | grep DATASOURCE_

sudo apt update
sudo apt install -y mysql-server

sudo systemctl enable mysql
sudo systemctl start mysql

sudo mysql <<SQL
CREATE DATABASE IF NOT EXISTS eschool;
CREATE USER IF NOT EXISTS '${DATASOURCE_USERNAME}'@'%' IDENTIFIED BY '${DATASOURCE_PASSWORD}';
GRANT ALL PRIVILEGES ON eschool.* TO '${DATASOURCE_USERNAME}'@'%';
FLUSH PRIVILEGES;
SQL

sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' \
  /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql