#!/bin/bash
#pull onos docker
echo "pulling ONOS docker"
docker pull onosproject/onos:2.2.2
docker run -t -d --name onos onosproject/onos:2.2.2
docker inspect onos | grep -i ipaddress
