#!/bin/bash
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard_failover.sh
# table 201 WAN primary
# table 202 WAN Failover
# table 203 U-LTE Failover
#
# curl -LJo /mnt/data/on_boot.d/10-wireguard_failover.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard_failover.sh
# chmod +x /mnt/data/on_boot.d/10-wireguard_failover.sh
###############
logfile=0
sleeptime=30
wireguard_interface=("wg0")
###############

[ ! -z "$sleep_time" ] || sleep_time=0

while sleep $sleep_time
do

	for config in "${wireguard_interface[@]}"
		do
			if [ -f /etc/wireguard/$wireguard_interface.conf ]; then
				using_table=`cat /var/log/messages | grep wan-failover-groups | grep "table" | tail -n1 | grep -oE '201|202|203'`
				if [ $using_table = 201 ]; then
					sleep_time=$sleeptime
					[ ! -z "$failover" ] || failover=0
					if [ $failover = 1 ]; then
						wg-quick down $wireguard_interface
						wg-quick up $wireguard_interface
						unset failover
						[ $logfile = 1 ] && echo "$(date +%F_%H-%M-%S) WAN" >> /mnt/data/log/wireguard_failover
					fi
				else
					if [ $using_table = 202 ] || [ $using_table = 203 ]; then
						if [ $logfile = 1 ]; then
							[ ! -z "$failover" ] || failover=0
							[ $failover = 0 ] && echo "$(date +%F_%H-%M-%S) WAN_Failover" >> /mnt/data/log/wireguard_failover
						fi
						sleep_time=$sleeptime
						failover=1
					fi
				fi
			fi
		done

done
