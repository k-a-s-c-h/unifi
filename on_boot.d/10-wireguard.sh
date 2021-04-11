#!/bin/sh
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard.sh
#
# curl -LJo /mnt/data/on_boot.d/10-wireguard.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard.sh
# chmod +x /mnt/data/on_boot.d/10-wireguard.sh

if [ -f /mnt/data/wireguard/setup_wireguard.sh ]; then
	cd /mnt/data/wireguard
	./setup_wireguard.sh
	if [ -f /usr/bin/wg-quick ]; then
		wg-quick up wg0
	fi
fi