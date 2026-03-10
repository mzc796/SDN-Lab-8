# SDN-Lab-7plus
In the previous lab, we manipulated the topology view of the OpenDaylight controller using precise link manipulation. In this lab, we will explore whether a similar approach works on the ONOS controller.

Your task is to experiment with flow rules, understand how topology discovery behaves under manipulation, and how to achieve the attack goal even in different settings.
## References

[ONOS REST API](https://wiki.onosproject.org/display/ONOS/Appendix+B%3A+REST+API)

[ONOS flow rules configuration](https://wiki.onosproject.org/display/ONOS/Flow+Rules)

## Precise Link Manipulation on ONOS controller
Read the script `pois_link.sh` and reason about how it can be used to manipulate ONOS link discovery.

The goal is to make the real topology appear as the deceptive topology shown below.

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
1. Utilize `pois_link.sh` in the way of what we did with OpenDaylight for SDN-Lab-7, and observe whether the ONOS controller discovers the deceptive topology.

2. Investigate what happens during the attempt by:

   (1) Capture packets using Wireshark

   (2) Inspect switch flow tables using dump_flows.sh (SDN-Lab-8/mn_scripts/)

3. Analyze the result: Does the topology manipulation succeed?

If not, what prevents the attack from working as expected?

4. Based on your observations, explain:

   (1) What assumptions about topology discovery does the attack rely on?

   (2) How might an attacker modify the approach to achieve precise link manipulation on ONOS?


