#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh
# table 201 WAN Primary
# table 202 WAN Failover
# table 203 U-LTE Failover

while sleep 240
do

if [`cat /var/log/messages | grep wanFailover | grep "using table" | tail -n1 | awk '{print $11}'` = 201 ]; then
	[ ! -z "$failover_up" ] || failover_up=0
	if [ $failover_up = 1 ]; then
		wg-quick down wg0
		wg-quick up wg0
		unset failover_up
	fi
else
	if [`cat /var/log/messages | grep wanFailover | grep "using table" | tail -n1 | awk '{print $11}'` = 202 ] || [`cat /var/log/messages | grep wanFailover | grep "using table" | tail -n1 | awk '{print $11}'` = 203 ]; then
		failover_up = 1
	fi
fi
done