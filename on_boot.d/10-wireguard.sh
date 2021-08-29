#!/bin/bash
# @k-a-s-c-h on GitHub
# @0815 on ubnt forums
# file is located at https://github.com/k-a-s-c-h/unifi/blob/main/on_boot.d/10-wireguard.sh
#
# curl -LJo /mnt/data/on_boot.d/10-wireguard.sh https://raw.githubusercontent.com/k-a-s-c-h/unifi/main/on_boot.d/10-wireguard.sh
# chmod +x /mnt/data/on_boot.d/10-wireguard.sh
###############
download=0
wireguard_interface=("wg0")
###############

for config in "${wireguard_interface[@]}"
	do
		if [ -d /mnt/data/wireguard ]; then
			if [ -f /mnt/data/wireguard/setup_wireguard.sh ]; then
				cd /mnt/data/wireguard
				./setup_wireguard.sh
				if [ -f /usr/bin/wg-quick ] && [ -f /etc/wireguard/$wireguard_interface.conf ]; then
					wg-quick up $wireguard_interface
				fi
			fi
		else
			if [ $download = 1 ];then
				lastrelease=`curl -sL https://api.github.com/repos/tusc/wireguard-kmod/releases/latest | jq -r '.assets[].browser_download_url'`
				curl -sLJo /mnt/data/wireguard-kmod.tar.Z $lastrelease
				if [ -f /mnt/data/wireguard-kmod.tar.Z ]; then
					tar -C /mnt/data -xzf /mnt/data/wireguard-kmod.tar.Z
					rm /mnt/data/wireguard-kmod.tar.Z
					if [ -f /mnt/data/wireguard/setup_wireguard.sh ]; then
						cd /mnt/data/wireguard
						./setup_wireguard.sh
						if [ -f /usr/bin/wg-quick ] && [ -f /etc/wireguard/$wireguard_interface.conf ]; then
							wg-quick up $wireguard_interface
						fi
					fi
				fi
			fi
		fi
	done