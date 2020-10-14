#!/bin/sh

########################################
# Zabbix
# example to generate backup (pg_dump -U zabbix zabbix | gzip > ZABBIX-DB.gz)

echo "Stop dependent containers"
docker-compose stop zb-web
docker-compose stop zb-agent
docker-compose stop zb-server
docker-compose stop pg-zb-server
sleep 2s

echo "Starting pg-zb-server"
docker-compose start pg-zb-server
sleep 2s

echo "Remove zabbix database"
docker exec -it pg-zb-server dropdb zabbix -U zabbix
sleep 2s

echo "Create new zabbix database"
docker exec -i pg-zb-server psql -U zabbix -d postgres -c "CREATE DATABASE zabbix"
sleep 2s

echo "Migrate database data to zabbix"
gunzip -c ./MIGRATE/ZABBIX-DB.gz | docker exec -i pg-zb-server psql -U zabbix -d zabbix > null
sleep 2s

echo "Starting containers again"
docker-compose start zb-web
docker-compose start zb-agent
docker-compose start zb-server

echo "Zabbix completed"
