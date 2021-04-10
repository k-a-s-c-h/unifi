#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh

while sleep 240
do
	
wan1=primary
wan2=none
ulte=backup

if [ $wan1=primary ] && [ $ulte = backup ]; then
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
fi

if [ $wan1=primary ] && [ $wan2 = backup ]; then
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
fi

if [ $wan2=primary ] && [ $ulte = backup ]; then
	if [ `cat /var/log/messages | grep wanFailover | grep "using table" | cut -d":" -f7 | tail -n1 | sed 's/, gre1//g'` = up ]; then
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
fi

if [ $wan2=primary ] && [ $wan1 = backup ]; then
	if [ `cat /var/log/messages | grep wanFailover | grep "using table" | cut -d":" -f7 | tail -n1 | sed 's/, gre1//g'` = up ]; then
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
fi
done