# SDN-Lab-7plus

## References

[ONOS REST API](https://wiki.onosproject.org/display/ONOS/Appendix+B%3A+REST+API)

[ONOS flow rules configuration](https://wiki.onosproject.org/display/ONOS/Flow+Rules)

## Precise Link Manipulation on ONOS controller
1. Last class, we have poisoned the topology view of OpenDaylight controller with precise link manipulation. How do you think of poisoning the topology view of ONOS controller? You can read `pois_link.sh` script to reason about how to poison the topology of ONOS controller. The goal is still to make the real topology (first) show as the deceptive topology (second).

Real Topology:
   ```
               Switch_C 2-------------------1 Switch_B
                  1                              2
                  |                              |
                  2                              3
   Host_1 --3 Switch_A 1---1 Switch_D 2---2 Switch_E 1----Host_2
   ```
Deceptive Topology:
```
            Switch_B 2--------------------1 Switch_E 3----Host_2
                1                              2
                |                              |
                2                              2
   Host_1 --3 Switch_A 1---2 Switch_C 1---1 Switch_D
   ```
3. 
