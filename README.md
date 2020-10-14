## Zabbix-Pgsql-Nginx-Grafana-PhpIpam

Monitoring system with Zabbix, Grafana and PhpIpam documentation

#### System up
```shell script
Rename EXAMPLE.env
mv EXAMPLE.env .env

Adjust environment variables on .env

Start system
docker-compose --compatibility up -d
```

#### Volumes
```shell script
    ### Mibs && alertscripts
    - /var/zb-server-alerts:/usr/lib/zabbix/alertscripts
    - /var/zb-server-mibs:/var/lib/zabbix/mibs
    
    ### Database backup path
    - /var/pg-zb-server:/var/lib/postgresql/data
    - /var/pg-grafana-data:/var/lib/postgresql/data
```

#### Recreate 
```shell script
# Modify File Permissions
chmod +x ./amaterasu.sh

# If you want to migrate data, put the bkp files in MIGRATE folder 
chmod +x ./migrate-grafana.sh
chmod +x ./migrate-zabbix.sh

# Clear all - be careful!
./amaterasu.sh
```
