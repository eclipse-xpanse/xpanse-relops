#!/bin/bash
set -e

echo "Running activiti DB and user creation."

# Use here-doc to pass SQL to mysql
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
  CREATE DATABASE IF NOT EXISTS activiti;
  CREATE USER IF NOT EXISTS 'activiti'@'%' IDENTIFIED BY '${MYSQL_ACTIVITI_PASSWORD}';
  GRANT ALL PRIVILEGES ON activiti.* TO 'activiti'@'%';
  FLUSH PRIVILEGES;
EOSQL