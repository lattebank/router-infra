#!/bin/bash

sysctl -w fs.file-max=40960000
sysctl -w fs.nr_open=40960000
sysctl -w net.core.rmem_default=16777216
sysctl -w net.core.wmem_default=16777216
sysctl -w net.core.rmem_max=16777216
sysctl -w net.core.wmem_max=16777216
sysctl -w net.core.netdev_budget=100000
sysctl -w net.core.netdev_max_backlog=300000
sysctl -w net.core.somaxconn=65535
sysctl -w net.core.busy_poll=100
sysctl -w net.core.busy_read=100
sysctl -w net.core.dev_weight=100000
sysctl -w net.core.rps_sock_flow_entries=32768
sysctl -w net.ipv4.ip_local_port_range="1024 65535"
sysctl -w net.ipv4.tcp_tw_recycle=0
sysctl -w net.ipv4.tcp_tw_reuse=1
sysctl -w net.ipv4.tcp_max_tw_buckets=10000000
sysctl -w net.ipv4.tcp_fin_timeout=1
sysctl -w net.ipv4.tcp_max_syn_backlog=100000
sysctl -w net.ipv4.tcp_rmem="4096 87380 16777216"
sysctl -w net.ipv4.tcp_wmem="4096 65536 16777216"
sysctl -w net.ipv4.tcp_sack=0
sysctl -w net.ipv4.tcp_timestamps=0
sysctl -w net.ipv4.tcp_low_latency=1
sysctl -w net.ipv4.tcp_adv_win_scale=1
sysctl -w net.ipv4.tcp_window_scaling=1
sysctl -w net.ipv4.tcp_max_orphans=32768
sysctl -w net.netfilter.nf_conntrack_max=10000000
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_established=40
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_close=10
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_close_wait=10
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_fin_wait=10
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_last_ack=10
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_syn_recv=10
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_syn_sent=10
sysctl -w net.netfilter.nf_conntrack_tcp_timeout_time_wait=1
sysctl -w net.ipv4.tcp_syncookies=0

ethtool -G eth0 rx 4096 tx 4096

echo ff > /sys/class/net/eth0/queues/rx-0/rps_cpus
echo ff > /sys/class/net/eth0/queues/rx-1/rps_cpus
echo 1048576 > /proc/sys/net/core/rps_sock_flow_entries
echo 524288 > /sys/class/net/eth0/queues/rx-0/rps_flow_cnt
echo 524288 > /sys/class/net/eth0/queues/rx-1/rps_flow_cnt
