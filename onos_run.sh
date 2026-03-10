#!/bin/bash
docker run -t -d --name onos onosproject/onos:2.2.2
docker inspect onos | grep -i ipaddress
