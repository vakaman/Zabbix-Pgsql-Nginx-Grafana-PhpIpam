#!/bin/bash

# Stop all containers
docker stop $(docker ps -qa)

# Remove all containers
docker rm $(docker ps -qa)

# Remove all images
docker rmi -f $(docker images -qa )

# Remove all volumes
docker volume rm $(docker volume ls -q --filter dangling=true)

# Remove all networks
docker network rm $(docker network ls -q)

# Remove if you need to persist
sudo rm -rf /var/pg-*
sudo rm -rf /var/phpipam-*
sudo rm -rf /var/zb-server-*
