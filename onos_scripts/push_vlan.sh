#!/bin/bash
echo "pushing vlan poisonous flow entry to node $1, inport $2, ether src $3, vlan_id $4, output $5"
curl -u onos:rocks -X POST "172.17.0.2:8181/onos/v1/flows/of:000000000000000$1" -H "content-type: application/json" -d '{
    "priority":40001,
    "timeout":0,
    "isPermanent": true,
    "deviceId": "of:000000000000000'$1'",
    "treatment": {
      "instructions": [
      	{
	"type":"L2MODIFICATION",
	"subtype":"VLAN_PUSH"
	},
      	{
	"type":"L2MODIFICATION",
	"subtype":"VLAN_ID",
	"vlanId":'$4'
	},
        {
        "type": "OUTPUT",
	"port": "'$5'"
        }
      ]
    },
    "selector":{
      "criteria": [
        {
        "type": "ETH_SRC",
	"mac": "'$3'"
        },
	{
	"type": "IN_PORT",
	"port": "'$2'"
	}
      ]
    }

}'
