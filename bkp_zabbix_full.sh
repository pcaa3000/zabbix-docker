#!/bin/bash
BDUSR=`cat env_vars/.MYSQL_USER`
BDPWD=`cat env_vars/.MYSQL_PASSWORD`
CNR=zabbix-docker-mysql-server-1
DIR="./backups"

if [ ! -d "$DIR" ]; then
  echo "Directory does not exist. Creating it now..."
  mkdir -p "$DIR"
fi

docker exec -i $CNR mysqldump -u$BDUSR -p"$BDPWD" --single-transaction --skip-lock-tables \
  --routines --triggers \
  zabbix | gzip > $DIR/zabbix_backup_full_$(date +%F).sql.gz

