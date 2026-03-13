# SDN-Lab-8
In the previous lab, we manipulated the topology view of the OpenDaylight controller using precise link manipulation. In this lab, we will explore whether a similar approach works on the ONOS controller.

Your task is to experiment with flow rules, understand how topology discovery behaves under manipulation, and how to achieve the attack goal even in different settings.
## References

[ONOS REST API](https://wiki.onosproject.org/display/ONOS/Appendix+B%3A+REST+API)

[ONOS flow rules configuration](https://wiki.onosproject.org/display/ONOS/Flow+Rules)

[Manipulating OpenFlow Link Discovery Packet Forwarding for Topology Poisoning (CCS'24)](https://dl.acm.org/doi/abs/10.1145/3658644.3690345)

## Settingup SDN testbed with ONOS and mininet

1. Prepare the system
   
   ```sudo ./sys_prep.sh```
2. Add and activate $USER to the docker group. $USER is the recent user of your Ubuntu system
   ```
   sudo usermod -aG docker $USER
   newgrp docker
   ```
3. Install and run onos dockers. The onos should have IP Addresses 172.17.0.2.
   
   ```./build_onos_dockers.sh```
4. Login the ONOS UI
    click Firefox, access http://172.17.0.2:8181/onos/ui
   ```
    user: onos
    password: rocks
   ```
5. After the ONOS UI is loaded, there should be three ONOS listed on each of the UIs as they build a cluster.
6. On http://172.17.0.2:8181/onos/ui, click the menu on the top left, go to Application, search openflow, choose OpenFlow Provider Suite, click the triangle on the top right to activate this application, confirm-> Okay.
7. Still on the Application list, search fwd, choose Reactive Forwarding, click the triangle on the top right to activate this application, confirm-> Okay.

8. Run Mininet to connect with ONOS.

    Open another teriminal
    ```
    cd mn_scripts/
    sudo ./mn_run.sh
    ```
    
    Wait for seconds and go back to refresh the browsers for each of the three controllers, you should be able to see a 5-node topology. 
9. Trigger Host Discovery
    on Mininet terminal:
    
    ```mininet>h1 ping h2```
    
    On the UI, click Menu->Network->Hosts, we will find h1 and h2.
10. Host Discovery on UIs
    
    On Topology GUI, hit the 'H' key on the keyboard, and the hosts will show up. For details, see https://wiki.onosproject.org/display/ONOS/Basic+ONOS+Tutorial#:~:text=To%20toggle%20between%20showing%20and,which%20they%20are%20the%20master.
    
    NOTE: Now we can see the shortest path from h1 to h2 is ```h1->sw1->sw4->sw5->h2``` as shown on the Topology GUI.
11. Check Flow Entries and Shortest Path Routing
    
    On the UI, click Menu->Network->Devices. Choose ```of:0000000000000001``` (sw1). On the top right, click `show flow view for selected device`, we can see that sw1 has been configured two flow entries by ```Application: fwd```      to forward the packets of h1 ping h2. Similarly, we will find that sw4 and sw5 are also configured with flow entries to support h1 ping h2. ```sw1->sw4->sw5``` is the shortest path as we can see from the topology.
12. Stop h1 ping h2 with ```Control+C``` on the Mininet terminal to prepare for the next step.
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
   
5. After precise link manipulation, does the `h1 ping h2` still work? Why?

6. Utilities:

   (1) Run ONOS container: `run_onos.sh`

   (2) Stop ONOS container: `stop_onos.sh`

   (3) Remove ONOS container: `rm_onos.sh`
