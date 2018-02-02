#!/bin/bash

TUN0_NETWORK=$(ip addr show dev tun0|grep -E "inet "|grep -v secondary|awk '{print $2}')
TUN0_MASTER_IP=$(echo ${TUN0_NETWORK}|awk -F '/' '{print $1}')
TUN0_PREFIX=$(echo ${TUN0_NETWORK}|awk -F '/' '{print $2}')
CLUSTER_NETWORK=$(ip route|grep tun0|grep -v 172.3|awk '{print $1}')

IFS=. read ip1 ip2 ip3 ip4 <<< ${TUN0_MASTER_IP}

for count in `seq 1 9`;
do
   let ip4=255-count
   IP=${ip1}.${ip2}.${ip3}.${ip4}
   ip addr add ${IP}/${TUN0_PREFIX} dev tun0
   ovs-ofctl -O OpenFlow13 add-flow br0 table=0,priority=400,in_port=2,ip,nw_src=${IP},actions=goto_table:30
   ovs-ofctl -O OpenFlow13 add-flow br0 table=0,priority=200,in_port=2,arp,nw_src=${IP},nw_dst=${CLUSTER_NETWORK},actions=goto_table:30
   ovs-ofctl -O OpenFlow13 add-flow br0 table=30,priority=300,arp,nw_dst=${IP},actions=output:2
   ovs-ofctl -O OpenFlow13 add-flow br0 table=30,priority=300,ip,nw_dst=${IP},actions=output:2
   ovs-ofctl -O OpenFlow13 add-flow br0 table=80,priority=300,ip,nw_src=${IP},actions=output:NXM_NX_REG2[]
done
