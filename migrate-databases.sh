#!/bin/bash

# Stop dependent container's
echo "Stop container's"
docker-compose stop zb-web
docker-compose stop zb-agent
docker-compose stop zb-server
docker-compose stop pg-zb-server
sleep 2s

echo "Starting pg-zb-server"
# Start only pg-zb-server
docker-compose start pg-zb-server
sleep 2s

echo "Remove zabbix database"
# Remove zabbix db
docker exec -it pg-zb-server dropdb zabbix -U zabbix
sleep 2s

echo "Create new zabbix database"
# Create database zabbix
docker exec -i pg-zb-server psql -U zabbix -d postgres -c "CREATE DATABASE  zabbix"
sleep 2s

echo "Migrate database data to zabbix"
# Migrate databases
gunzip -c ./MIGRATE/ZABBIX-DB.gz | docker exec -i pg-zb-server psql -U zabbix -d zabbix > null

# Start container's
echo "Starting container's"
docker-compose start zb-web
docker-compose start zb-agent
docker-compose start zb-server

