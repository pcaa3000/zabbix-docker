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
  --ignore-table=zabbix.history \
  --ignore-table=zabbix.history_uint \
  --ignore-table=zabbix.history_str \
  --ignore-table=zabbix.history_text \
  --ignore-table=zabbix.history_log \
  --ignore-table=zabbix.trends \
  --ignore-table=zabbix.trends_uint \
  zabbix | gzip > $DIR/zabbix_config_only_$(date +%F).sql.gz

