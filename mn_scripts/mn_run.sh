#!/bin/bash
sudo mn --controller remote,ip=172.17.0.2 --custom motivating_example_topo.py --topo mytopo --switch ovs,protocols=OpenFlow13
