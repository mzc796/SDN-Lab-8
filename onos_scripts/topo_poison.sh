#!/bin/bash

#push_vlan $1:node, $2:inport, $3:ether_src, $4:vid, $5:output
#match_vlan $1:node $2:vid $3:output $4:controller_id
#pop_vlan $1:node $2:vid $3:controller_id

#A2->1B
sudo ./push_vlan.sh 3 1 $1 1 2 
sudo ./pop_vlan.sh 2 1
#B1->2A
sudo ./push_vlan.sh 3 2 $1 2 1 
sudo ./pop_vlan.sh 1 2

#D1->1C
sudo ./push_vlan.sh 1 1 $1 3 2 
sudo ./pop_vlan.sh 3 3
#C1->1D
sudo ./push_vlan.sh 1 2 $1 4 1 
sudo ./pop_vlan.sh 4 4


#C2->1A
sudo ./push_vlan.sh 2 1 $1 5 2 
sudo ./match_vlan.sh 5 5 2
sudo ./match_vlan.sh 4 5 1
sudo ./pop_vlan.sh 1 5
#A1->2C
sudo ./push_vlan.sh 4 1 $1 6 2 
sudo ./match_vlan.sh 5 6 1
sudo ./match_vlan.sh 2 6 1
sudo ./pop_vlan.sh 3 6


