#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard.sh
#
# curl -LJo /mnt/data/on_boot.d/10-wireguard.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard.sh
# chmod +x /mnt/data/on_boot.d/10-wireguard.sh

if [ -d /mnt/data/wireguard/ ]; then
	[ ! -f /usr/bin/wg-quick ] && ln -s /mnt/data/wireguard/usr/bin/wg-quick /usr/bin/wg-quick
	[ ! -f /usr/bin/wg ] && ln -s /mnt/data/wireguard/usr/bin/wg /usr/bin/wg
	[ ! -f /usr/bin/bash ] && ln -s /mnt/data/wireguard/usr/bin/bash /usr/bin/bash
	[ ! -d /etc/wireguard ] && ln -s /mnt/data/wireguard/etc/wireguard /etc/wireguard
	[ ! -d /dev/fd ] && ln -s /proc/self/fd /dev/fd &>/dev/null > /dev/null 2>&1
	[ `lsmod | egrep ^ip6_udp_tunnel | wc -l` = 0 ] && modprobe ip6_udp_tunnel
	[ `lsmod | egrep ^udp_tunnel | wc -l` = 0 ] && modprobe udp_tunnel
	if [ `lsmod | egrep ^wireguard | wc -l` = 1 ]; then
		ver=`uname -r`
		echo "loading wireguard..."
		insmod /mnt/data/wireguard/wireguard-$ver.ko
		insmod /mnt/data/wireguard/iptable_raw-$ver.ko
	fi
	if [ -f /usr/bin/wg-quick ]; then
		sleep 60
		wg-quick up wg0
	fi
fi