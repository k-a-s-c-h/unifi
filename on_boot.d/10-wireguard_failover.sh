#!/bin/sh
while sleep 240
do
	if [ `cat /var/log/messages | grep wanFailover | grep "using table" | cut -d":" -f9 | tail -n1 | sed 's/)//g'` = up ]; then
		if [ -f /tmp/failover_up ]; then
			wg-quick down wg0
			sleep 5
			wg-quick up wg0
			rm /tmp/failover_up
		fi
	else
		if [ ! -f /tmp/failover_up ]; then
			touch /tmp/failover_up
		fi
	fi
done