#!/bin/sh

########################################
# Grafana
# example to generate backup (pg_dump -U grafana grafana | gzip > GRAFANA.gz)

echo "Stop dependent containers"
docker-compose stop gf-web
docker-compose stop pg-grafana
sleep 2s

echo "Starting pg-grafana"
docker-compose start pg-grafana
sleep 2s

echo "Remove grafana database"
docker exec -it pg-grafana dropdb grafana -U grafana
sleep 2s

echo "Create new grafana database"
docker exec -i pg-grafana psql -U grafana -d postgres -c "CREATE DATABASE grafana"
sleep 2s

echo "Migrate database data to grafana"
gunzip -c ./MIGRATE/GRAFANA-DB.gz | docker exec -i pg-grafana psql -U grafana -d grafana > null

echo "Start dependent containers"
docker-compose start gf-web

echo "Grafana completed"
