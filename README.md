## Zabbix-Pgsql-Nginx-Grafana-PhpIpam

Monitoring system with Zabbix and Grafana and PhpIpam documentation

#### System up
```shell script
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

# Clear all
./amaterasu.sh
```
